import SQLite3

extension SKLite {
    
    public static func fileName(db: Connection, database: String = "main") -> String? {
        var s: UnsafePointer<Int8>?
        database.withCString{ cString in
            s = sqlite3_db_filename(db, database)
        }
        if s == nil {
            return nil
        }
        return String(cString: s!)
    }
    
    @available(OSX 10.8, *)
    @inline(__always)
    public static func readable(db: Connection, database: String = "main") -> Bool {
        return sqlite3_db_readonly(db, database) != -1
    }
    
    @available(OSX 10.8, *)
    @inline(__always)
    public static func writable(db: Connection, database: String = "main") -> Bool {
        return sqlite3_db_readonly(db, database) == 0
    }
    
    @available(OSX 10.8, *)
    @inline(__always)
    public static func readOnly(db: Connection, database: String = "main") -> Bool {
        return sqlite3_db_readonly(db, database) == 1
    }
    
    @inline(__always)
    public static func autoCommit(_ db: Connection) -> Bool {
        return sqlite3_get_autocommit(db) != 0
    }
    
    @inline(__always)
    public static func limit(_ db: Connection, limit: Limit) -> Int32 {
        return sqlite3_limit(db, limit.rawValue, -1)
    }
    
    @discardableResult
    @inline(__always)
    public static func setLimit(_ db: Connection, limit: Limit, newValue: Int32) -> Int32 {
        return sqlite3_limit(db, limit.rawValue, newValue)
    }
    
    @discardableResult
    public static func status(db: Connection, op: DbStatus, resetHighwater: Bool = false) throws -> (current: Int32, highwater: Int32) {
        var current: Int32 = 0
        var highwater: Int32 = 0
        try check(result: sqlite3_db_status(db, op.rawValue, &current, &highwater, resetHighwater ? 1 : 0), db: db)
        return (current, highwater)
    }
    
    /**
     每个 SQLite 表中的条目（除了 WITHOUT ROWID 表）都有一个唯一的 64 位有符号整数键，称为 "rowid"。
     Rowid 始终作为一个未声明的列名为 ROWID、OID 或 ROWID 存在，只要这些名称不被明确声明的列使用。如果表具有 INTEGER PRIMARY KEY 类型的列，那么该列也是 rowid 的另一个别名。
     sqlite3_last_insert_rowid 函数:
     sqlite3_last_insert_rowid(D) 函数通常返回在数据库连接 D 上最近成功的对 rowid 表或虚拟表的 INSERT 的 rowid。
     对 WITHOUT ROWID 表的插入不记录在内。
     如果在数据库连接 D 上从未发生过对 rowid 表的成功插入，则 sqlite3_last_insert_rowid(D) 返回零。
     除了在插入数据库表时自动设置之外，此函数返回的值也可以通过 sqlite3_set_last_insert_rowid() 显式设置。
     对于一些虚拟表实现，它们在提交事务时可能会向 rowid 表插入行（例如，将内存中累积的数据刷新到磁盘）。在这种情况下，后续对此函数的调用会返回与这些内部 INSERT 操作关联的 rowid，导致不直观的结果。遇到这种情况的虚拟表实现可以通过在返回控制权给用户之前使用 sqlite3_set_last_insert_rowid() 恢复原始的 rowid 值来避免此问题。
     插入触发器:
     如果触发器内发生 INSERT 操作，那么此函数将返回插入的行的 rowid，只要触发器正在运行。触发器程序结束后，此函数的返回值将恢复到触发器触发之前的值。
     约束冲突:
     由于约束冲突而失败的 INSERT 不算是成功的 [INSERT]，不会改变此函数返回的值。因此，INSERT OR FAIL、INSERT OR IGNORE、INSERT OR ROLLBACK 和 INSERT OR ABORT 在插入失败时不会更改此接口的返回值。当 INSERT OR REPLACE 遇到约束冲突时，它不会失败。INSERT 继续完成后，删除导致约束问题的行，因此 INSERT OR REPLACE 总是会更改此接口的返回值。
     事务回滚:
     对于此函数，即使插入后随后被回滚，插入也被认为是成功的。
     最后，该函数可以通过 last_insert_rowid() SQL function 在 SQL 语句中访问。如果在 sqlite3_last_insert_rowid() 函数运行时，另一个线程在同一数据库连接上执行新的 INSERT，从而更改了最后插入的 [rowid]，那么 sqlite3_last_insert_rowid() 返回的值是不可预测的，可能不等于旧的或新的最后插入的 [rowid]。
     */
    @inline(__always)
    public static func lastInsertRowId(_ db: Connection) -> Int {
        return Int(sqlite3_last_insert_rowid(db))
    }
    
    @inline(__always)
    public static func setLastInsertRowId(_ db: Connection, rowId: Int) {
        sqlite3_set_last_insert_rowid(db, sqlite3_int64(rowId))
    }
    
    /**
     这个函数返回最近一次在指定数据库连接上完成的 INSERT、UPDATE 或 DELETE语句修改、插入或删除的行数。
     执行其他类型的 SQL 语句不会修改该函数返回的值。
     */
    @inline(__always)
    public static func changes(_ db: Connection) -> Int {
        return Int(sqlite3_changes(db))
    }
    
    /**
     此函数返回自数据库连接打开以来完成的所有 INSERT、UPDATE 或 DELETE 语句插入、修改或删除的总行数，包括作为触发器程序的一部分执行的行为。
     执行其他类型的 SQL 语句不会修改该函数返回的值。
     */
    @inline(__always)
    public static func totalChanges(_ db: Connection) -> Int {
        return Int(sqlite3_total_changes(db))
    }
    
    /// 强制将 SQLite 数据库的写缓存（page cache）刷新到磁盘
    @available(OSX 10.12, iOS 10.0, *)
    @inline(__always)
    public static func cacheFlush(db: Connection) throws {
        try check(result: sqlite3_db_cacheflush(db), db: db)
    }
    
    /// 用于中断正在执行的 SQLite 查询，使其尽快返回 SQLITE_INTERRUPT 错误。
    /// 适用于多线程场景，允许一个线程安全地终止另一个线程的查询。
    /// 不会影响数据库连接，中断后可以继续执行其他 SQL 语句。
    @inline(__always)
    public static func interrupt(db: Connection) {
        sqlite3_interrupt(db)
    }
    
    /// 释放 SQLite 数据库连接的缓存内存
    /// 尝试释放 SQLite 连接 db 关联的缓存内存（如 page cache、lookaside memory）。
    /// 不影响数据库内容，仅减少 SQLite 进程的内存占用。
    /// 适用于内存紧张的场景，可以主动调用以减少 SQLite 的 RAM 占用。
    @inline(__always)
    public static func releaseMemory(db: Connection) throws {
        try check(result: sqlite3_db_release_memory(db), db: db)
    }
    
    @inline(__always)
    public static func errCode(_ db: Connection) -> SKLiteError {
        return SKLiteError(rawValue: sqlite3_errcode(db))
    }
    
    @inline(__always)
    public static func errMsg(_ db: Connection) -> String {
        return String(cString: sqlite3_errmsg(db)!)
    }
    
    @inline(__always)
    public static func extendedErrCode(_ db: Connection) -> SKLiteError {
        return SKLiteError(rawValue: sqlite3_extended_errcode(db))
    }
    
    @inline(__always)
    public static func exec(_ db: Connection, sql: String) throws {
        try check(result: sqlite3_exec(db, sql, nil, nil, nil), db: db)
    }
}
