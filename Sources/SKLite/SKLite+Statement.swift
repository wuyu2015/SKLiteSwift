import SQLite3

extension SKLite {
    
    @inline(__always)
    public static func sql(stmt: Statement) -> String {
        return String(cString: sqlite3_sql(stmt))
    }
    
    @inlinable
    public static func expandedSql(stmt: Statement) -> String {
        if #available(OSX 10.12, *) {
            return String(cString: sqlite3_expanded_sql(stmt))
        } else {
            return String(cString: sqlite3_sql(stmt))
        }
    }
    
    @inline(__always)
    public static func readOnly(stmt: Statement) -> Bool {
        return sqlite3_stmt_readonly(stmt) != 0
    }
    
    @available(OSX 10.15, iOS 13.0, *)
    @inline(__always)
    public static func isExplain(stmt: Statement) -> Bool {
        return sqlite3_stmt_isexplain(stmt) != 0
    }
    
    @available(OSX 10.15, iOS 13.0, *)
    @inline(__always)
    public static func isExplainQueryPlan(stmt: Statement) -> Bool {
        return sqlite3_stmt_isexplain(stmt) == 2
    }
    
    @inline(__always)
    public static func busy(stmt: Statement) -> Bool {
        return sqlite3_stmt_busy(stmt) != 0
    }
    
    @inline(__always)
    public static func dataCount(stmt: Statement) -> Int32 {
        return sqlite3_data_count(stmt)
    }
}
