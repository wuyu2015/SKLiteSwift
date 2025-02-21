import Foundation
import SQLite3

extension SKLite {
    public struct SKLiteError: OptionSet, Error, LocalizedError {
        public let rawValue: Int32
        public let message: String
        public let sql: String
        
        private var separatorLine: String {
            return message.isEmpty ? "-----" : String(repeating: "-", count: min(message.count + 7, 80))
        }
        
        public var errorDescription: String? {
            return sql.isEmpty ?
            """
            
            [SKLite Error]
             CODE: \(rawValue)
              MSG: \(message)
            \(separatorLine)
            """
            :
            """
            
            [SQLite Error]
             CODE: \(rawValue)
              MSG: \(message)
              SQL: \(sql)
            -----
            """
        }
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
            self.message = SKLite.errStr(rawValue)
            self.sql = ""
        }
        
        public init(rawValue: Int32, message: String) {
            self.rawValue = rawValue
            self.message = message
            self.sql = ""
        }
        
        public init(rawValue: Int32, message: String?, sql: String) {
            self.rawValue = rawValue
            self.message = message ?? SKLite.errStr(rawValue)
            self.sql = sql
        }
        
        /// SQLITE_OK, 0, 操作成功
        public static let OK = SKLiteError(rawValue: SQLITE_OK)

        /// SQLITE_ERROR, 1, 通用错误
        public static let ERROR = SKLiteError(rawValue: SQLITE_ERROR)

        /// SQLITE_INTERNAL, 2, SQLite 内部逻辑错误
        public static let INTERNAL = SKLiteError(rawValue: SQLITE_INTERNAL)

        /// SQLITE_PERM, 3, 访问权限被拒绝
        public static let PERM = SKLiteError(rawValue: SQLITE_PERM)

        /// SQLITE_ABORT, 4, 回调函数请求中止操作
        public static let ABORT = SKLiteError(rawValue: SQLITE_ABORT)

        /// SQLITE_BUSY, 5, 数据库文件被锁定
        public static let BUSY = SKLiteError(rawValue: SQLITE_BUSY)

        /// SQLITE_LOCKED, 6, 数据库中的表被锁定
        public static let LOCKED = SKLiteError(rawValue: SQLITE_LOCKED)

        /// SQLITE_NOMEM, 7, 内存分配失败
        public static let NOMEM = SKLiteError(rawValue: SQLITE_NOMEM)

        /// SQLITE_READONLY, 8, 试图写入只读数据库
        public static let READONLY = SKLiteError(rawValue: SQLITE_READONLY)

        /// SQLITE_INTERRUPT, 9, 操作被 sqlite3_interrupt() 终止
        public static let INTERRUPT = SKLiteError(rawValue: SQLITE_INTERRUPT)

        /// SQLITE_IOERR, 10, 发生某种类型的磁盘 I/O 错误
        public static let IOERR = SKLiteError(rawValue: SQLITE_IOERR)

        /// SQLITE_CORRUPT, 11, 数据库磁盘映像损坏
        public static let CORRUPT = SKLiteError(rawValue: SQLITE_CORRUPT)

        /// SQLITE_NOTFOUND, 12, sqlite3_file_control() 中的未知操作码
        public static let NOTFOUND = SKLiteError(rawValue: SQLITE_NOTFOUND)

        /// SQLITE_FULL, 13, 数据库已满，插入操作失败
        public static let FULL = SKLiteError(rawValue: SQLITE_FULL)

        /// SQLITE_CANTOPEN, 14, 无法打开数据库文件
        public static let CANTOPEN = SKLiteError(rawValue: SQLITE_CANTOPEN)

        /// SQLITE_PROTOCOL, 15, 数据库锁定协议错误
        public static let PROTOCOL = SKLiteError(rawValue: SQLITE_PROTOCOL)

        /// SQLITE_EMPTY, 16, 仅供内部使用
        public static let EMPTY = SKLiteError(rawValue: SQLITE_EMPTY)

        /// SQLITE_SCHEMA, 17, 数据库架构已更改
        public static let SCHEMA = SKLiteError(rawValue: SQLITE_SCHEMA)

        /// SQLITE_TOOBIG, 18, 字符串或 BLOB 超过大小限制
        public static let TOOBIG = SKLiteError(rawValue: SQLITE_TOOBIG)

        /// SQLITE_CONSTRAINT, 19, 由于约束违规而中止
        public static let CONSTRAINT = SKLiteError(rawValue: SQLITE_CONSTRAINT)

        /// SQLITE_MISMATCH, 20, 数据类型不匹配
        public static let MISMATCH = SKLiteError(rawValue: SQLITE_MISMATCH)

        /// SQLITE_MISUSE, 21, 库的错误使用
        public static let MISUSE = SKLiteError(rawValue: SQLITE_MISUSE)

        /// SQLITE_NOLFS, 22, 使用主机不支持的 OS 功能
        public static let NOLFS = SKLiteError(rawValue: SQLITE_NOLFS)

        /// SQLITE_AUTH, 23, 授权被拒绝
        public static let AUTH = SKLiteError(rawValue: SQLITE_AUTH)

        /// SQLITE_FORMAT, 24, 不使用
        public static let FORMAT = SKLiteError(rawValue: SQLITE_FORMAT)

        /// SQLITE_RANGE, 25, sqlite3_bind 的第二个参数超出范围
        public static let RANGE = SKLiteError(rawValue: SQLITE_RANGE)

        /// SQLITE_NOTADB, 26, 打开的文件不是数据库文件
        public static let NOTADB = SKLiteError(rawValue: SQLITE_NOTADB)

        /// SQLITE_NOTICE, 27, 来自 sqlite3_log() 的通知
        public static let NOTICE = SKLiteError(rawValue: SQLITE_NOTICE)

        /// SQLITE_WARNING, 28, 来自 sqlite3_log() 的警告
        public static let WARNING = SKLiteError(rawValue: SQLITE_WARNING)

        /// SQLITE_ROW, 100, sqlite3_step() 有另一行数据可用
        public static let ROW = SKLiteError(rawValue: SQLITE_ROW)

        /// SQLITE_DONE, 101, sqlite3_step() 执行完成
        public static let DONE = SKLiteError(rawValue: SQLITE_DONE)


        /// SQLITE_ERROR_MISSING_COLLSEQ (SQLITE_ERROR | (1<<8))
        public static let ERROR_MISSING_COLLSEQ = SKLiteError(rawValue: 0x101)

        /// SQLITE_ERROR_RETRY (SQLITE_ERROR | (2<<8))
        public static let ERROR_RETRY = SKLiteError(rawValue: 0x201)

        /// SQLITE_ERROR_SNAPSHOT (SQLITE_ERROR | (3<<8))
        public static let ERROR_SNAPSHOT = SKLiteError(rawValue: 0x301)


        /// SQLITE_IOERR_READ (SQLITE_IOERR | (1<<8))
        public static let IOERR_READ = SKLiteError(rawValue: 0x10A)

        /// SQLITE_IOERR_SHORT_READ (SQLITE_IOERR | (2<<8))
        public static let IOERR_SHORT_READ = SKLiteError(rawValue: 0x20A)

        /// SQLITE_IOERR_WRITE (SQLITE_IOERR | (3<<8))
        public static let IOERR_WRITE = SKLiteError(rawValue: 0x30A)

        /// SQLITE_IOERR_FSYNC (SQLITE_IOERR | (4<<8))
        public static let IOERR_FSYNC = SKLiteError(rawValue: 0x40A)

        /// SQLITE_IOERR_DIR_FSYNC (SQLITE_IOERR | (5<<8))
        public static let IOERR_DIR_FSYNC = SKLiteError(rawValue: 0x50A)

        /// SQLITE_IOERR_TRUNCATE (SQLITE_IOERR | (6<<8))
        public static let IOERR_TRUNCATE = SKLiteError(rawValue: 0x60A)

        /// SQLITE_IOERR_FSTAT (SQLITE_IOERR | (7<<8))
        public static let IOERR_FSTAT = SKLiteError(rawValue: 0x70A)

        /// SQLITE_IOERR_UNLOCK (SQLITE_IOERR | (8<<8))
        public static let IOERR_UNLOCK = SKLiteError(rawValue: 0x80A)

        /// SQLITE_IOERR_RDLOCK (SQLITE_IOERR | (9<<8))
        public static let IOERR_RDLOCK = SKLiteError(rawValue: 0x90A)

        /// SQLITE_IOERR_DELETE (SQLITE_IOERR | (10<<8))
        public static let IOERR_DELETE = SKLiteError(rawValue: 0xA0A)

        /// SQLITE_IOERR_BLOCKED (SQLITE_IOERR | (11<<8))
        public static let IOERR_BLOCKED = SKLiteError(rawValue: 0xB0A)

        /// SQLITE_IOERR_NOMEM (SQLITE_IOERR | (12<<8))
        public static let IOERR_NOMEM = SKLiteError(rawValue: 0xC0A)

        /// SQLITE_IOERR_ACCESS (SQLITE_IOERR | (13<<8))
        public static let IOERR_ACCESS = SKLiteError(rawValue: 0xD0A)

        /// SQLITE_IOERR_CHECKRESERVEDLOCK (SQLITE_IOERR | (14<<8))
        public static let IOERR_CHECKRESERVEDLOCK = SKLiteError(rawValue: 0xE0A)

        /// SQLITE_IOERR_LOCK (SQLITE_IOERR | (15<<8))
        public static let IOERR_LOCK = SKLiteError(rawValue: 0xF0A)

        /// SQLITE_IOERR_CLOSE (SQLITE_IOERR | (16<<8))
        public static let IOERR_CLOSE = SKLiteError(rawValue: 0x100A)

        /// SQLITE_IOERR_DIR_CLOSE (SQLITE_IOERR | (17<<8))
        public static let IOERR_DIR_CLOSE = SKLiteError(rawValue: 0x110A)

        /// SQLITE_IOERR_SHMOPEN (SQLITE_IOERR | (18<<8))
        public static let IOERR_SHMOPEN = SKLiteError(rawValue: 0x120A)

        /// SQLITE_IOERR_SHMSIZE (SQLITE_IOERR | (19<<8))
        public static let IOERR_SHMSIZE = SKLiteError(rawValue: 0x130A)

        /// SQLITE_IOERR_SHMLOCK (SQLITE_IOERR | (20<<8))
        public static let IOERR_SHMLOCK = SKLiteError(rawValue: 0x140A)

        /// SQLITE_IOERR_SHMMAP (SQLITE_IOERR | (21<<8))
        public static let IOERR_SHMMAP = SKLiteError(rawValue: 0x150A)

        /// SQLITE_IOERR_SEEK (SQLITE_IOERR | (22<<8))
        public static let IOERR_SEEK = SKLiteError(rawValue: 0x160A)

        /// SQLITE_IOERR_DELETE_NOENT (SQLITE_IOERR | (23<<8))
        public static let IOERR_DELETE_NOENT = SKLiteError(rawValue: 0x170A)

        /// SQLITE_IOERR_MMAP (SQLITE_IOERR | (24<<8))
        public static let IOERR_MMAP = SKLiteError(rawValue: 0x180A)

        /// SQLITE_IOERR_GETTEMPPATH (SQLITE_IOERR | (25<<8))
        public static let IOERR_GETTEMPPATH = SKLiteError(rawValue: 0x190A)

        /// SQLITE_IOERR_CONVPATH (SQLITE_IOERR | (26<<8))
        public static let IOERR_CONVPATH = SKLiteError(rawValue: 0x1A0A)

        /// SQLITE_IOERR_VNODE (SQLITE_IOERR | (27<<8))
        public static let IOERR_VNODE = SKLiteError(rawValue: 0x1B0A)

        /// SQLITE_IOERR_AUTH (SQLITE_IOERR | (28<<8))
        public static let IOERR_AUTH = SKLiteError(rawValue: 0x1C0A)

        /// SQLITE_IOERR_BEGIN_ATOMIC (SQLITE_IOERR | (29<<8))
        public static let IOERR_BEGIN_ATOMIC = SKLiteError(rawValue: 0x1D0A)

        /// SQLITE_IOERR_COMMIT_ATOMIC (SQLITE_IOERR | (30<<8))
        public static let IOERR_COMMIT_ATOMIC = SKLiteError(rawValue: 0x1E0A)

        /// SQLITE_IOERR_ROLLBACK_ATOMIC (SQLITE_IOERR | (31<<8))
        public static let IOERR_ROLLBACK_ATOMIC = SKLiteError(rawValue: 0x1F0A)

        /// SQLITE_IOERR_DATA (SQLITE_IOERR | (32<<8))
        public static let IOERR_DATA = SKLiteError(rawValue: 0x200A)

        /// SQLITE_IOERR_CORRUPTFS (SQLITE_IOERR | (33<<8))
        public static let IOERR_CORRUPTFS = SKLiteError(rawValue: 0x210A)


        /// SQLITE_LOCKED_SHAREDCACHE (SQLITE_LOCKED |  (1<<8))
        public static let LOCKED_SHAREDCACHE = SKLiteError(rawValue: 0x106)

        /// SQLITE_LOCKED_VTAB (SQLITE_LOCKED |  (2<<8))
        public static let LOCKED_VTAB = SKLiteError(rawValue: 0x206)


        /// SQLITE_BUSY_RECOVERY (SQLITE_BUSY   |  (1<<8))
        public static let BUSY_RECOVERY = SKLiteError(rawValue: 0x105)

        /// SQLITE_BUSY_SNAPSHOT (SQLITE_BUSY   |  (2<<8))
        public static let BUSY_SNAPSHOT = SKLiteError(rawValue: 0x205)

        /// SQLITE_BUSY_TIMEOUT (SQLITE_BUSY   |  (3<<8))
        public static let BUSY_TIMEOUT = SKLiteError(rawValue: 0x305)


        /// SQLITE_CANTOPEN_NOTEMPDIR (SQLITE_CANTOPEN | (1<<8))
        public static let CANTOPEN_NOTEMPDIR = SKLiteError(rawValue: 0x10E)

        /// SQLITE_CANTOPEN_ISDIR (SQLITE_CANTOPEN | (2<<8))
        public static let CANTOPEN_ISDIR = SKLiteError(rawValue: 0x20E)

        /// SQLITE_CANTOPEN_FULLPATH (SQLITE_CANTOPEN | (3<<8))
        public static let CANTOPEN_FULLPATH = SKLiteError(rawValue: 0x30E)

        /// SQLITE_CANTOPEN_CONVPATH (SQLITE_CANTOPEN | (4<<8))
        public static let CANTOPEN_CONVPATH = SKLiteError(rawValue: 0x40E)

        /// SQLITE_CANTOPEN_DIRTYWAL (SQLITE_CANTOPEN | (5<<8)) /* Not Used */
        public static let CANTOPEN_DIRTYWAL = SKLiteError(rawValue: 0x50E)

        /// SQLITE_CANTOPEN_SYMLINK (SQLITE_CANTOPEN | (6<<8))
        public static let CANTOPEN_SYMLINK = SKLiteError(rawValue: 0x60E)

        /// SQLITE_CORRUPT_VTAB (SQLITE_CORRUPT | (1<<8))
        public static let CORRUPT_VTAB = SKLiteError(rawValue: 0x10B)

        /// SQLITE_CORRUPT_SEQUENCE (SQLITE_CORRUPT | (2<<8))
        public static let CORRUPT_SEQUENCE = SKLiteError(rawValue: 0x20B)

        /// SQLITE_CORRUPT_INDEX (SQLITE_CORRUPT | (3<<8))
        public static let CORRUPT_INDEX = SKLiteError(rawValue: 0x30B)

        /// SQLITE_READONLY_RECOVERY (SQLITE_READONLY | (1<<8))
        public static let READONLY_RECOVERY = SKLiteError(rawValue: 0x108)

        /// SQLITE_READONLY_CANTLOCK (SQLITE_READONLY | (2<<8))
        public static let READONLY_CANTLOCK = SKLiteError(rawValue: 0x208)

        /// SQLITE_READONLY_ROLLBACK (SQLITE_READONLY | (3<<8))
        public static let READONLY_ROLLBACK = SKLiteError(rawValue: 0x308)

        /// SQLITE_READONLY_DBMOVED (SQLITE_READONLY | (4<<8))
        public static let READONLY_DBMOVED = SKLiteError(rawValue: 0x408)

        /// SQLITE_READONLY_CANTINIT (SQLITE_READONLY | (5<<8))
        public static let READONLY_CANTINIT = SKLiteError(rawValue: 0x508)

        /// SQLITE_READONLY_DIRECTORY (SQLITE_READONLY | (6<<8))
        public static let READONLY_DIRECTORY = SKLiteError(rawValue: 0x608)


        /// SQLITE_ABORT_ROLLBACK (SQLITE_ABORT | (2<<8))
        public static let ABORT_ROLLBACK = SKLiteError(rawValue: 0x204)


        /// SQLITE_CONSTRAINT_CHECK (SQLITE_CONSTRAINT | (1<<8))
        public static let CONSTRAINT_CHECK = SKLiteError(rawValue: 0x113)

        /// SQLITE_CONSTRAINT_COMMITHOOK (SQLITE_CONSTRAINT | (2<<8))
        public static let CONSTRAINT_COMMITHOOK = SKLiteError(rawValue: 0x213)

        /// SQLITE_CONSTRAINT_FOREIGNKEY (SQLITE_CONSTRAINT | (3<<8))
        public static let CONSTRAINT_FOREIGNKEY = SKLiteError(rawValue: 0x313)

        /// SQLITE_CONSTRAINT_FUNCTION (SQLITE_CONSTRAINT | (4<<8))
        public static let CONSTRAINT_FUNCTION = SKLiteError(rawValue: 0x413)

        /// SQLITE_CONSTRAINT_NOTNULL (SQLITE_CONSTRAINT | (5<<8))
        public static let CONSTRAINT_NOTNULL = SKLiteError(rawValue: 0x513)

        /// SQLITE_CONSTRAINT_PRIMARYKEY (SQLITE_CONSTRAINT | (6<<8))
        public static let CONSTRAINT_PRIMARYKEY = SKLiteError(rawValue: 0x613)

        /// SQLITE_CONSTRAINT_TRIGGER (SQLITE_CONSTRAINT | (7<<8))
        public static let CONSTRAINT_TRIGGER = SKLiteError(rawValue: 0x713)

        /// SQLITE_CONSTRAINT_UNIQUE (SQLITE_CONSTRAINT | (8<<8))
        public static let CONSTRAINT_UNIQUE = SKLiteError(rawValue: 0x813)

        /// SQLITE_CONSTRAINT_VTAB (SQLITE_CONSTRAINT | (9<<8))
        public static let CONSTRAINT_VTAB = SKLiteError(rawValue: 0x913)

        /// SQLITE_CONSTRAINT_ROWID (SQLITE_CONSTRAINT |(10<<8))
        public static let CONSTRAINT_ROWID = SKLiteError(rawValue: 0xA13)

        /// SQLITE_CONSTRAINT_PINNED (SQLITE_CONSTRAINT |(11<<8))
        public static let CONSTRAINT_PINNED = SKLiteError(rawValue: 0xB13)

        /// SQLITE_CONSTRAINT_DATATYPE (SQLITE_CONSTRAINT |(12<<8))
        public static let CONSTRAINT_DATATYPE = SKLiteError(rawValue: 0xC13)


        /// SQLITE_NOTICE_RECOVER_WAL (SQLITE_NOTICE | (1<<8))
        public static let NOTICE_RECOVER_WAL = SKLiteError(rawValue: 0x11B)

        /// SQLITE_NOTICE_RECOVER_ROLLBACK (SQLITE_NOTICE | (2<<8))
        public static let NOTICE_RECOVER_ROLLBACK = SKLiteError(rawValue: 0x21B)


        /// SQLITE_WARNING_AUTOINDEX (SQLITE_WARNING | (1<<8))
        public static let WARNING_AUTOINDEX = SKLiteError(rawValue: 0x11C)


        /// SQLITE_AUTH_USER (SQLITE_AUTH | (1<<8))
        public static let AUTH_USER = SKLiteError(rawValue: 0x117)


        /// SQLITE_OK_LOAD_PERMANENTLY (SQLITE_OK | (1<<8))
        public static let OK_LOAD_PERMANENTLY = SKLiteError(rawValue: 0x100)
    }
}
