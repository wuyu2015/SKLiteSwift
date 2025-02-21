import SQLite3

extension SKLite {
    public struct OpenFlag: OptionSet {
        public let rawValue: Int32
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
        
        /// SQLITE_OPEN_READONLY: 打开数据库为只读模式，不允许进行写操作。
        public static let READONLY = OpenFlag(rawValue: SQLITE_OPEN_READONLY)
        /// SQLITE_OPEN_READWRITE: 打开数据库为读写模式，允许进行读和写操作。
        public static let READWRITE = OpenFlag(rawValue: SQLITE_OPEN_READWRITE)
        /// SQLITE_OPEN_CREATE: 如果数据库不存在，则创建一个新的数据库。
        public static let CREATE = OpenFlag(rawValue: SQLITE_OPEN_CREATE)
        // SQLITE_OPEN_DELETEONCLOSE: 数据库在关闭时应该被删除。
//        public static let DELETEONCLOSE = OpenFlag(rawValue: SQLITE_OPEN_DELETEONCLOSE) // 在我的 macOS 此参数无效，所以将其注释。
        // SQLITE_OPEN_EXCLUSIVE: Note in particular that the SQLITE_OPEN_EXCLUSIVE flag is a no-op for sqlite3_open_v2(). The SQLITE_OPEN_EXCLUSIVE does *not* cause the open to fail if the database already exists. The SQLITE_OPEN_EXCLUSIVE flag is intended for use by the VFS interface only, and not by sqlite3_open_v2().
//        public static let EXCLUSIVE = OpenFlag(rawValue: SQLITE_OPEN_EXCLUSIVE)
        /// SQLITE_OPEN_AUTOPROXY: 数据库连接应该尝试使用适合当前操作系统和环境的默认代理。
        public static let AUTOPROXY = OpenFlag(rawValue: SQLITE_OPEN_AUTOPROXY)
        /// SQLITE_OPEN_URI: 标志允许数据库名是一个 URI，如文件路径。
        public static let URI = OpenFlag(rawValue: SQLITE_OPEN_URI)
        /// SQLITE_OPEN_MEMORY: 打开一个内存数据库。
        public static let MEMORY = OpenFlag(rawValue: SQLITE_OPEN_MEMORY)

        // 这些标志是给虚拟文件系统 (VFS) 使用的，用于打开主数据库、临时数据库和临时的数据库。
        public static let MAIN_DB = OpenFlag(rawValue: SQLITE_OPEN_MAIN_DB) /* VFS only */
        public static let TEMP_DB = OpenFlag(rawValue: SQLITE_OPEN_TEMP_DB) /* VFS only */
        public static let TRANSIENT_DB = OpenFlag(rawValue: SQLITE_OPEN_TRANSIENT_DB) /* VFS only */

        // 这些标志是给虚拟文件系统 (VFS) 使用的，用于打开主日志、临时日志、子日志和主日志。
        public static let MAIN_JOURNAL = OpenFlag(rawValue: SQLITE_OPEN_MAIN_JOURNAL) /* VFS only */
        public static let TEMP_JOURNAL = OpenFlag(rawValue: SQLITE_OPEN_TEMP_JOURNAL) /* VFS only */
        public static let SUBJOURNAL = OpenFlag(rawValue: SQLITE_OPEN_SUBJOURNAL) /* VFS only */
        public static let MASTER_JOURNAL = OpenFlag(rawValue: SQLITE_OPEN_MASTER_JOURNAL) /* VFS only */

        /// SQLITE_OPEN_NOMUTEX: 禁用数据库连接的互斥锁。如果你确定只会在单个线程中使用 SQLite，可以禁用 SQLite 的互斥锁，以提高性能。
        public static let NOMUTEX = OpenFlag(rawValue: SQLITE_OPEN_NOMUTEX)
        /// SQLITE_OPEN_FULLMUTEX: 启用数据库连接的全互斥锁。
        public static let FULLMUTEX = OpenFlag(rawValue: SQLITE_OPEN_FULLMUTEX)
        /// SQLITE_OPEN_SHAREDCACHE: 启用数据库连接的共享缓存。
        public static let SHAREDCACHE = OpenFlag(rawValue: SQLITE_OPEN_SHAREDCACHE)
        /// SQLITE_OPEN_PRIVATECACHE: 启用数据库连接的私有缓存。
        public static let PRIVATECACHE = OpenFlag(rawValue: SQLITE_OPEN_PRIVATECACHE)
        /// SQLITE_OPEN_WAL: 启用数据库连接的写入日志模式。
        public static let WAL = OpenFlag(rawValue: SQLITE_OPEN_WAL)

        // SQLITE_OPEN_FILEPROTECTION_COMPLETE, SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN, SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION, SQLITE_OPEN_FILEPROTECTION_NONE, SQLITE_OPEN_FILEPROTECTION_MASK: 这些标志是用于设置数据库文件保护级别的，仅适用于 iOS 平台。
        public static let FILEPROTECTION_COMPLETE = OpenFlag(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETE)
        public static let FILEPROTECTION_COMPLETEUNLESSOPEN = OpenFlag(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN)
        public static let FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION = OpenFlag(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION)
        public static let FILEPROTECTION_NONE = OpenFlag(rawValue: SQLITE_OPEN_FILEPROTECTION_NONE)
        public static let FILEPROTECTION_MASK = OpenFlag(rawValue: SQLITE_OPEN_FILEPROTECTION_MASK)
    }
}
