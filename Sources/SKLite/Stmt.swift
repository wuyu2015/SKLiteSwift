import SQLite3

extension SKLite {
    open class Stmt {
        
        // MARK: prop
        public let db: Db
        public let stmt: Statement
        private var finalized: Bool = false
        
        public var dataCount: Int32 {
            @inline(__always) get {
                return sqlite3_data_count(stmt)
            }
        }
        
        /// 与准备语句关联的原f始 SQL 字符串
        public lazy var sql: String = {
            return String(cString: sqlite3_sql(stmt))
        }()
        
        public var expandedSql: String {
            if #available(OSX 10.12, *) {
                return String(cString: sqlite3_expanded_sql(stmt))
            } else {
                return String(cString: sqlite3_sql(stmt))
            }
        }
        
        public var isBusy: Bool {
            @inline(__always) get {
                return sqlite3_stmt_busy(stmt) != 0
            }
        }
        
        @available(OSX 10.15, iOS 13.0, *)
        public var isExplain: Bool {
            @inline(__always) get {
                return sqlite3_stmt_isexplain(stmt) != 0
            }
        }
        
        @available(OSX 10.15, iOS 13.0, *)
        public var isExplainQueryPlan: Bool {
            @inline(__always) get {
                return sqlite3_stmt_isexplain(stmt) == 2
            }
        }
        
        public var isReadOnly: Bool {
            @inline(__always) get {
                return sqlite3_stmt_readonly(stmt) != 0
            }
        }
        
        // MARK: init
        public init(db: Db, sql: String) throws {
            self.db = db
            var pointer: Statement?
            let result = sqlite3_prepare_v2(db.db, sql, -1, &pointer, nil)
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result, message: db.errMsg, sql: sql)
            }
            stmt = pointer!
        }
        
        
        // MARK: func
        @inlinable
        @discardableResult
        public func bindBlob(index: Int32, value: [UInt8]) throws -> Self {
            try value.withUnsafeBytes {
                let result = sqlite3_bind_blob(stmt, index, $0.baseAddress!, Int32(value.count), unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                guard result == SQLITE_OK else {
                    throw SKLiteError(rawValue: result, message: db.errMsg, sql: expandedSql)
                }
            }
            return self
        }
        
        @inlinable
        @discardableResult
        public func bindDouble(index: Int32, value: Double) throws -> Self {
            let result = sqlite3_bind_double(stmt, index, value)
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result, message: db.errMsg, sql: expandedSql)
            }
            return self
        }
        
        @inlinable
        @discardableResult
        public func bindInt(index: Int32, value: Int) throws -> Self {
            let result = sqlite3_bind_int64(stmt, index, sqlite3_int64(value))
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result, message: db.errMsg, sql: expandedSql)
            }
            return self
        }
        
        @inlinable
        @discardableResult
        public func bindNull(index: Int32) throws -> Self {
            let result = sqlite3_bind_null(stmt, index)
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result, message: db.errMsg, sql: expandedSql)
            }
            return self
        }
        
        @inlinable
        @discardableResult
        public func bindString(index: Int32, value: String) throws -> Self {
            let result = sqlite3_bind_text(stmt, index, strdup(value), -1, { free($0) })
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result, message: db.errMsg, sql: expandedSql)
            }
            return self
        }
        
        @inlinable
        @discardableResult
        public func bindZeroBlob(index: Int32, count: Int) throws -> Self {
            let result: Int32
            if #available(OSX 10.12, iOS 10.0, *) {
                result = sqlite3_bind_zeroblob64(stmt, index, sqlite3_uint64(count))
            } else {
                result = sqlite3_bind_zeroblob(stmt, index, Int32(count))
            }
            guard result == SQLITE_OK else {
                throw SKLiteError(rawValue: result, message: db.errMsg, sql: expandedSql)
            }
            return self
        }
        
        @inlinable
        @discardableResult
        public func clearBindings() throws -> Self {
            let result = sqlite3_clear_bindings(stmt)
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result, message: db.errMsg, sql: sql)
            }
            return self
        }
        
        @inline(__always)
        public func finalize() throws {
            if !finalized {
                let result = sqlite3_finalize(stmt)
                guard result == SQLITE_OK else {
                    throw SKLite.SKLiteError(rawValue: result, message: db.errMsg)
                }
                finalized = true
            }
        }
        
        @inline(__always)
        public func getBlob(index: Int32) -> UnsafeRawPointer? {
            return sqlite3_column_blob(stmt, index)
        }
        
        @inline(__always)
        public func getBlobCount(index: Int32) -> Int {
            return Int(sqlite3_column_bytes(stmt, index))
        }
        
        @inline(__always)
        public func getInt(index: Int32) -> Int {
            return Int(sqlite3_column_int64(stmt, index))
        }
        
        @inline(__always)
        public func getDouble(index: Int32) -> Double {
            return sqlite3_column_double(stmt, index)
        }
        
        @inline(__always)
        public func getString(index: Int32) -> String {
            return String(cString: sqlite3_column_text(stmt, index))
        }
        
        @inline(__always)
        @discardableResult
        public func reset() -> Self {
            sqlite3_reset(stmt)
            return self
        }
        
        @discardableResult
        public func step(retries: Int = 10) throws -> Bool {
            let result = sqlite3_step(stmt)
            switch(result) {
            case SQLITE_ROW:
                return true
            case SQLITE_DONE:
                return false
            case SQLITE_BUSY, SQLITE_LOCKED:
                for retry in 0..<max(retries, 0) {
                    let retryResult: Int32 = sqlite3_step(stmt)
                    switch(retryResult) {
                    case SQLITE_ROW:
                        return true
                    case SQLITE_DONE:
                        return false
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
                        throw SKLiteError(rawValue: retryResult, message: errMsg(sqlite3_db_handle(stmt)), sql: sql)
                    }
                }
                throw SKLiteError(rawValue: result, message: errMsg(sqlite3_db_handle(stmt)), sql: sql)
            default:
                throw SKLiteError(rawValue: result, message: errMsg(sqlite3_db_handle(stmt)), sql: sql)
            }
        }
        
        deinit {
            try? finalize()
        }
    }
}
