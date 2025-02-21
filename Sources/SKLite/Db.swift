import Foundation
import SQLite3

extension SKLite {
    open class Db {
        // MARK: prop
        public let db: Connection
        private var closed: Bool = false
        
        public var autoCommit: Bool {
            @inlinable get {
                return sqlite3_get_autocommit(db) != 0
            }
        }
        
        public var changes: Int {
            @inlinable get {
                return Int(sqlite3_changes(db))
            }
        }
        
        public var errCode: SKLiteError {
            @inlinable get {
                return SKLiteError(rawValue: sqlite3_errcode(db))
            }
        }
        
        public var errMsg: String {
            @inlinable get {
                return String(cString: sqlite3_errmsg(db)!)
            }
        }
        
        public var extendedErrCode: SKLiteError {
            @inlinable get {
                return SKLiteError(rawValue: sqlite3_extended_errcode(db))
            }
        }
        
        public var lastInsertRowId: Int {
            @inlinable get {
                return Int(sqlite3_last_insert_rowid(db))
            }
            @inlinable set {
                sqlite3_set_last_insert_rowid(db, sqlite3_int64(newValue))
            }
        }
        
        public var totalChanges: Int {
            @inlinable get {
                return Int(sqlite3_total_changes(db))
            }
        }
        
        
        // MARK: init
        public init(_ filePath: String = ":memory:", flags: SKLite.OpenFlag = [.READWRITE]) throws {
            db = try open(filePath, flags: flags)
        }
        
        public init(_ fileURL: URL, flags: SKLite.OpenFlag = [.READWRITE]) throws {
            db = try open(fileURL, flags: flags)
        }
        
        public init(pathInDocumentDirectory path: String, flags: SKLite.OpenFlag = [.READWRITE]) throws {
            db = try openInDocumentDirectory(path, flags: flags)
        }
        
        public init(pathInHomeDirectory path: String, flags: SKLite.OpenFlag = [.READWRITE]) throws {
            db = try openInHomeDirectory(path, flags: flags)
        }
        
        public init(pathInDownloadsDirectory path: String, flags: SKLite.OpenFlag = [.READWRITE]) throws {
            db = try openInDownloadsDirectory(path, flags: flags)
        }
        
        
        // MARK: func
        @available(OSX 10.12, iOS 10.0, *)
        public func cacheFlush() throws {
            try check(result: sqlite3_db_cacheflush(db), db: db)
        }
        
        public func close() throws {
            if !closed {
                try SKLite.close(db)
                closed = true
            }
        }
        
        public func exec(_ sql: String) throws {
            try check(result: sqlite3_exec(db, sql, nil, nil, nil), db: db)
        }
        
        public func fileName(database: String = "main") -> String? {
            guard let s = sqlite3_db_filename(db, database) else {
                return nil
            }
            return String(cString: s)
        }
        
        public func interrupt(db: Connection) {
            sqlite3_interrupt(db)
        }
        
        public func prepare(sql: String) throws -> Stmt {
            return try Stmt(db: self, sql: sql)
        }
        
        @available(OSX 10.8, *)
        public func readable(database: String = "main") -> Bool {
            return sqlite3_db_readonly(db, database) != -1
        }
        
        @available(OSX 10.8, *)
        public func readOnly(database: String = "main") -> Bool {
            return sqlite3_db_readonly(db, database) == 1
        }
        
        public func releaseMemory() throws {
            try check(result: sqlite3_db_release_memory(db), db: db)
        }
        
        @discardableResult
        public func setLimit(limit: Limit, newValue: Int32) -> Int32 {
            return sqlite3_limit(db, limit.rawValue, newValue)
        }
        
        public func status(op: DbStatus, resetHighwater: Bool = false) throws -> (current: Int32, highwater: Int32) {
            var current: Int32 = 0
            var highwater: Int32 = 0
            try check(result: sqlite3_db_status(db, op.rawValue, &current, &highwater, resetHighwater ? 1 : 0), db: db)
            return (current, highwater)
        }
        
        @available(OSX 10.8, *)
        public func writable(database: String = "main") -> Bool {
            return sqlite3_db_readonly(db, database) == 0
        }
        
        // MARK: deinit
        deinit {
            try? close()
        }
    }
}
