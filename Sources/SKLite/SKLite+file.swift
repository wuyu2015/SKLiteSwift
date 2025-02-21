import Foundation
import SQLite3

extension SKLite {
    // MARK: var
    static let fileManager = FileManager.default
    
    static let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    static let homeDirectoryURL: URL = {
        #if os(macOS)
        if #available(OSX 10.12, *) {
            return FileManager.default.homeDirectoryForCurrentUser
        } else {
            return URL(fileURLWithPath: NSHomeDirectory())
        }
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return URL(fileURLWithPath: NSHomeDirectory())  // iOS 及 Apple 设备使用沙盒目录
        #elseif os(Linux)
        return FileManager.default.homeDirectoryForCurrentUser
        #else
        return documentDirectoryURL.deletingLastPathComponent()
        #endif
    }()
    
    static let downloadsDirectoryURL: URL = {
        #if os(macOS) || os(Linux)
        return homeDirectoryURL.appendingPathComponent("Downloads")
        #else
        return homeDirectoryURL // 如果是 iOS, tvOS, watchOS，用 home 目录代替
        #endif
    }()
    
    
    // MARK: func
    static func touchDirectory(dir dirURL: URL) throws {
        if !fileManager.fileExists(atPath: dirURL.path) {
            // 创建目录（带中间目录）
            try fileManager.createDirectory(at: dirURL, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    static func touchDirectory(dir dirPath: String) throws {
        if !fileManager.fileExists(atPath: dirPath) {
            // 创建目录（带中间目录）
            try fileManager.createDirectory(at: URL(fileURLWithPath: dirPath), withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    static func touchDirectory(file fileURL: URL) throws {
        let dirURL = fileURL.deletingLastPathComponent() // 获取父级目录
        // 如果父文件夹不存在
        if !fileManager.fileExists(atPath: dirURL.path) {
            // 创建目录（带中间目录）
            try fileManager.createDirectory(at: dirURL, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    @inline(__always)
    static func touchDirectory(file filePath: String) throws {
        return try touchDirectory(file: URL(fileURLWithPath: filePath))
    }
    
    static func touch(_ fileURL: URL) throws {
        try touchDirectory(file: fileURL)
        fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
    }
    
    static func touch(_ filePath: String) throws {
        try touchDirectory(file: filePath)
        fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
    }
}
