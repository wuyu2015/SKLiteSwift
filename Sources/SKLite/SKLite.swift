import SQLite3

public enum SKLite {
    public typealias Connection = OpaquePointer
    public typealias Statement = OpaquePointer
    
    @inlinable
    public static func check(result: Int32, db: Connection) throws {
        guard result == SQLITE_OK else {
            throw SKLiteError(rawValue: result, message: errMsg(db))
        }
    }
    
    @inlinable
    public static func check(result: Int32, stmt: Statement) throws {
        guard result == SQLITE_OK else {
            throw SKLiteError(rawValue: result, message: errMsg(sqlite3_db_handle(stmt)), sql: sql(stmt: stmt))
        }
    }
}
