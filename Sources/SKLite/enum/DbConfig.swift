extension SKLite {
    public enum DbConfig: Int32 {
        /// 此选项用于更改“主”数据库模式的名称。
        case MAIN_DB_NAME = 1000
        
        /// 此选项需要三个额外的参数，用于确定数据库连接的lookaside内存分配器配置。
        case LOOKASIDE = 1001
        
        /// 此选项用于启用或禁用外键约束的执行。
        case ENABLE_FKEY = 1002
        
        /// 此选项用于启用或禁用触发器。
        case ENABLE_TRIGGER = 1003
        
        /// 此选项在系统提供的SQLite版本上不受支持。
        case ENABLE_FTS3_TOKENIZER = 1004
        
        /// 此选项在系统提供的SQLite版本上不受支持。
        case ENABLE_LOAD_EXTENSION = 1005
        
        /// 通常，当关闭或从数据库句柄中分离处于WAL模式的数据库时，SQLite会检查是否现在根本没有连接到数据库。
        case NO_CKPT_ON_CLOSE = 1006
        
        /// SQLITE_DBCONFIG_ENABLE_QPSG选项激活或停用查询规划器稳定性保证（QPSG）。
        case ENABLE_QPSG = 1007
        
        /// 默认情况下，EXPLAIN QUERY PLAN命令的输出不包括由触发器程序执行的任何操作的输出。
        case TRIGGER_EQP = 1008
        
        /// 设置SQLITE_DBCONFIG_RESET_DATABASE标志，然后运行VACUUM以将数据库重置为空数据库，没有模式和内容。
        case RESET_DATABASE = 1009
        
        /// SQLITE_DBCONFIG_DEFENSIVE选项激活或停用数据库连接的“防御”标志。
        case DEFENSIVE = 1010
        
        /// SQLITE_DBCONFIG_WRITABLE_SCHEMA选项激活或停用“writable_schema”标志。
        case WRITABLE_SCHEMA = 1011
    }
}
