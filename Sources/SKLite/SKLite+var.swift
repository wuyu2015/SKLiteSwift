import SQLite3

extension SKLite {
    // 如: 3.28.0
    public static let version: String = SQLITE_VERSION
    
    // 如: 3028000
    public static let versionNumber: Int32 = SQLITE_VERSION_NUMBER
    
    // 如: 2019-04-15 14:49:49 378230ae7f4b721c8b8d83c8ceb891449685cd23b1702a57841f1be40b5daapl
    public static let sourceId: String = SQLITE_SOURCE_ID
    
    public static var threadSafe: ThreadSafeLevel {
        return ThreadSafeLevel(rawValue: sqlite3_threadsafe())!
    }
    
    public static var isThreadSafe: Bool {
        return sqlite3_threadsafe() > 0
    }
    
    public static var isSingleThreaded: Bool {
        return sqlite3_threadsafe() == 1
    }
    
    public static var isMultiThreaded: Bool {
        return sqlite3_threadsafe() == 2
    }
    
    public static var tempDirectory: String? {
        get {
            guard let tempDir = sqlite3_temp_directory else {
                return nil
            }
            return String(cString: tempDir)
        }
        set {
            if let newValue = newValue {
                let cString = strdup(newValue)
                sqlite3_temp_directory = cString
            } else {
                sqlite3_temp_directory = nil
            }
        }
    }
    
    public static var dataDirectory: String? {
        get {
            guard let directory = sqlite3_data_directory else {
                return nil
            }
            return String(cString: directory)
        }
        set {
            if let newValue = newValue {
                let cString = strdup(newValue)
                sqlite3_data_directory = cString
            } else {
                sqlite3_data_directory = nil
            }
        }
    }
    
    public static let vfsName: String? = {
        guard let vfs = sqlite3_vfs_find(nil), let name = vfs.pointee.zName else {
            return nil
        }
        return String(cString: name)
    }()
}
