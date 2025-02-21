import Foundation
import SQLite3

extension SKLite {
    // MARK: open
    private static func openWithoutCheck(_ filePath: String, flags: SKLite.OpenFlag) throws -> SKLite.Connection {
        var dbPointer: SKLite.Connection?
        let result = sqlite3_open_v2(filePath, &dbPointer, flags.rawValue, nil)
        guard result == SQLITE_OK, dbPointer != nil else {
            let errMsg = String(cString: sqlite3_errmsg(dbPointer)!)
            if result != SQLITE_CANTOPEN {
                if #available(iOS 8.2, *) {
                    sqlite3_close_v2(dbPointer)
                } else {
                    sqlite3_close(dbPointer)
                }
            }
            throw SKLite.SKLiteError(rawValue: result, message: "\(errMsg): \(filePath)")
        }
        guard let db = dbPointer else {
            throw SKLite.SKLiteError(rawValue: result, message: "unable to open database file: \(filePath)")
        }
        return db
    }
    
    public static func open(_ filePath: String = ":memory:", flags: SKLite.OpenFlag = [.READWRITE]) throws -> SKLite.Connection {
        // 如果 flags 包含 .CREATE 且所在目录不存在，创建该目录。
        if flags.contains(.CREATE) && filePath != ":memory:" {
            try touchDirectory(file: filePath)
        }
        return try openWithoutCheck(filePath, flags: flags)
    }
    
    public static func open(_ fileURL: URL, flags: SKLite.OpenFlag = [.READWRITE]) throws -> SKLite.Connection {
        // 如果 flags 包含 .CREATE 且所在目录不存在，创建该目录。
        if flags.contains(.CREATE) {
            try touchDirectory(file: fileURL)
        }
        return try openWithoutCheck(fileURL.path, flags: flags)
    }
    
    @inline(__always)
    public static func openInDirectory(_ filePath: String, dir: URL, flags: SKLite.OpenFlag = [.READWRITE]) throws -> SKLite.Connection {
        return try open(dir.appendingPathComponent(filePath).path, flags: flags)
    }
    
    public static func openInDocumentDirectory(_ filePath: String, flags: SKLite.OpenFlag = [.READWRITE]) throws -> SKLite.Connection {
        return try openInDirectory(filePath, dir: documentDirectoryURL, flags: flags)
    }
    
    public static func openInHomeDirectory(_ filePath: String, flags: SKLite.OpenFlag = [.READWRITE]) throws -> SKLite.Connection {
        return try openInDirectory(filePath, dir: homeDirectoryURL, flags: flags)
    }
    
    public static func openInDownloadsDirectory(_ filePath: String, flags: SKLite.OpenFlag = [.READWRITE]) throws -> SKLite.Connection {
        return try openInDirectory(filePath, dir: downloadsDirectoryURL, flags: flags)
    }
    
    // MARK: remove
    @inline(__always)
    public static func remove(_ fileURL: URL) throws {
        try fileManager.removeItem(at: fileURL)
    }
    
    @inline(__always)
    public static func remove(_ filePath: String, dir: URL) throws {
        try fileManager.removeItem(at: dir.appendingPathComponent(filePath))
    }
    
    public static func removeInDocumentDirectory(_ filePath: String) throws {
        try remove(filePath, dir: documentDirectoryURL)
    }
    
    public static func removeInHomeDirectory(_ filePath: String) throws {
        try remove(filePath, dir: homeDirectoryURL)
    }
    
    public static func removeInDownloadsDirectory(_ filePath: String) throws {
        try remove(filePath, dir: downloadsDirectoryURL)
    }
    
    // MARK: close
    @discardableResult
    public static func close(_ db: SKLite.Connection, retries: Int = 10) throws -> Int {
        let result: Int32
        if #available(iOS 8.2, *) {
            result = sqlite3_close_v2(db)
        } else {
            result = sqlite3_close(db)
        }
        
        switch(result) {
        case SQLITE_OK:
            return 0
        case SQLITE_BUSY, SQLITE_LOCKED:
            for retry in 0..<max(retries, 1) {
                let resultRetry: Int32
                if #available(iOS 8.2, *) {
                    resultRetry = sqlite3_close_v2(db)
                } else {
                    resultRetry = sqlite3_close(db)
                }
                switch(resultRetry) {
                case SQLITE_OK:
                    return retry + 1
                case SQLITE_BUSY, SQLITE_LOCKED:
                    // 等待时间越来越长(毫秒)
                    if retry == 0 {
                        // 1st 0.02ms
                        usleep(20)
                    } else if retry == 1 {
                        // 2nd 0.25ms
                        usleep(250)
                    } else if retry <= 8 {
                        // 0.5ms, 2ms, 8ms, 32ms, 128ms, 512ms, 2048ms(2s)
                        usleep(useconds_t(500.0 * pow(4.0, Double(retry - 2))))
                    } else {
                        // 3s ...
                        usleep(3000000)
                    }
                default:
                    throw SKLite.SKLiteError(rawValue: result, message: String(cString: sqlite3_errmsg(db)!))
                }
            }
        default:
            throw SKLite.SKLiteError(rawValue: result, message: String(cString: sqlite3_errmsg(db)!))
        }
        return max(retries, 1)
    }
}
