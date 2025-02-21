import SQLite3

extension SKLite {
    
    @inline(__always)
    public static func bindInt(_ stmt: Statement, index: Int32, value: Int) throws {
        try check(result: sqlite3_bind_int64(stmt, index, sqlite3_int64(value)), stmt: stmt)
    }
    
    @inline(__always)
    public static func bindDouble(_ stmt: Statement, index: Int32, value: Double) throws {
        try check(result: sqlite3_bind_double(stmt, index, value), stmt: stmt)
    }
    
    @inline(__always)
    public static func bindString(_ stmt: Statement, index: Int32, value: String) throws {
        try check(result: sqlite3_bind_text(stmt, index, strdup(value), -1, { free($0) }), stmt: stmt)
    }
    
    @inlinable
    public static func bindBlob(_ stmt: Statement, index: Int32, value: [UInt8]) throws {
        try value.withUnsafeBytes {
            try check(result: sqlite3_bind_blob(stmt, index, $0.baseAddress!, Int32(value.count), unsafeBitCast(-1, to: sqlite3_destructor_type.self)), stmt: stmt)
        }
    }
    
    @inlinable
    public static func bindZeroBlob(_ stmt: Statement, index: Int32, count: Int) throws {
        if #available(OSX 10.12, iOS 10.0, *) {
            try check(result: sqlite3_bind_zeroblob64(stmt, index, sqlite3_uint64(count)), stmt: stmt)
        } else {
            try check(result: sqlite3_bind_zeroblob(stmt, index, Int32(count)), stmt: stmt)
        }
    }
    
    @inlinable
    public static func bindNull(_ stmt: Statement, index: Int32) throws {
        try check(result: sqlite3_bind_null(stmt, index), stmt: stmt)
    }
    
    @inlinable
    public static func clearBindings(_ stmt: Statement) throws {
        try check(result: sqlite3_clear_bindings(stmt), stmt: stmt)
    }
    
    @inline(__always)
    public static func getInt(_ stmt: Statement, index: Int32) -> Int {
        return Int(sqlite3_column_int64(stmt, index))
    }
    
    @inline(__always)
    public static func getDouble(_ stmt: Statement, index: Int32) -> Double {
        return sqlite3_column_double(stmt, index)
    }
    
    @inline(__always)
    public static func getString(_ stmt: Statement, index: Int32) -> String {
        return String(cString: sqlite3_column_text(stmt, index))
    }
    
    @inline(__always)
    public static func getBlob(_ stmt: Statement, index: Int32) -> UnsafeRawPointer? {
        return sqlite3_column_blob(stmt, index)
    }
    
    @inline(__always)
    public static func getBlobCount(_ stmt: Statement, index: Int32) -> Int32 {
        return sqlite3_column_bytes(stmt, index)
    }
}
