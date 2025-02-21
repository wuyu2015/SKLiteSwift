import SQLite3

extension SKLite {
    
    public static func prepare(_ db: Connection, sql: String) throws -> Statement {
        var pointer: Statement?
        let result = sqlite3_prepare_v2(db, sql, -1, &pointer, nil)
        guard result == SQLITE_OK else {
            throw SKLite.SKLiteError(rawValue: result, message: errMsg(db), sql: sql)
        }
        return pointer!
    }
    
    @inline(__always)
    public static func reset(_ stmt: Statement) {
        sqlite3_reset(stmt)
    }
    
    @inline(__always)
    public static func finalize(_ stmt: Statement) throws {
        try check(result: sqlite3_finalize(stmt), stmt: stmt)
    }
    
    @discardableResult
    public static func step(_ stmt: Statement, retries: Int = 10) throws -> Bool {
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
                    throw SKLiteError(rawValue: retryResult, message: errMsg(sqlite3_db_handle(stmt)), sql: sql(stmt: stmt))
                }
            }
            throw SKLiteError(rawValue: result, message: errMsg(sqlite3_db_handle(stmt)), sql: sql(stmt: stmt))
        default:
            throw SKLiteError(rawValue: result, message: errMsg(sqlite3_db_handle(stmt)), sql: sql(stmt: stmt))
        }
    }
}
