extension SKLite {
    public enum Limit: Int32 {
        /// 任何字符串、BLOB或表行的最大大小，以字节为单位
        case LENGTH = 0
        
        /// SQL语句的最大长度，以字节为单位
        case SQL_LENGTH
        
        /// 表定义中的最大列数，或者SELECT的结果集中的最大列数，或者索引中的最大列数，或者ORDER BY或GROUP BY子句中的最大列数
        case COLUMN
        
        /// 任何表达式的解析树的最大深度
        case EXPR_DEPTH
        
        /// 复合SELECT语句中的最大条款数
        case COMPOUND_SELECT
        
        /// 用于实现SQL语句的虚拟机程序中的最大指令数。如果sqlite3_prepare_v2()或等效方法尝试为单个预处理语句分配超过这么多个操作码的空间，则返回SQLITE_NOMEM错误
        case VDBE_OP
        
        /// 函数参数的最大数量
        case FUNCTION_ARG
        
        /// 附加数据库的最大数量
        case ATTACHED
        
        /// LIKE或GLOB操作符中模式参数的最大长度
        case LIKE_PATTERN_LENGTH
        
        /// SQL语句中任何参数的最大索引号
        case VARIABLE_NUMBER
        
        /// 触发器递归深度的最大值
        case TRIGGER_DEPTH
        
        /// 单个预处理语句可能启动的辅助工作线程的最大数量
        case WORKER_THREADS
    }
}
