extension SKLite {
    public enum CompileOption: String {
        /// 允许或禁止使用covering indices优化
        case ALLOW_COVERING_INDEX_SCAN = "ALLOW_COVERING_INDEX_SCAN"
        
        /// 允许或禁止URI中的身份验证信息
        case ALLOW_URI_AUTHORITY = "ALLOW_URI_AUTHORITY"
        
        /// 与兼容性相关的bug
        case BUG_COMPATIBLE_20160819 = "BUG_COMPATIBLE_20160819"
        
        /// 编译器类型
        case COMPILER = "COMPILER"
        
        /// 默认是否自动清理
        case DEFAULT_AUTOVACUUM = "DEFAULT_AUTOVACUUM"
        
        /// 默认缓存大小
        case DEFAULT_CACHE_SIZE = "DEFAULT_CACHE_SIZE"
        
        /// 默认检查点完全同步
        case DEFAULT_CKPTFULLFSYNC = "DEFAULT_CKPTFULLFSYNC"
        
        /// 默认日志大小限制
        case DEFAULT_JOURNAL_SIZE_LIMIT = "DEFAULT_JOURNAL_SIZE_LIMIT"
        
        /// 设置默认的lookaside内存分配
        case DEFAULT_LOOKASIDE = "DEFAULT_LOOKASIDE"
        
        /// 默认是否启用内存状态查询
        case DEFAULT_MEMSTATUS = "DEFAULT_MEMSTATUS"
        
        /// 默认页面大小
        case DEFAULT_PAGE_SIZE = "DEFAULT_PAGE_SIZE"
        
        /// 默认同步设置
        case DEFAULT_SYNCHRONOUS = "DEFAULT_SYNCHRONOUS"
        
        /// 默认的WAL同步设置
        case DEFAULT_WAL_SYNCHRONOUS = "DEFAULT_WAL_SYNCHRONOUS"
        
        /// 以EBCDIC编码存储和检索文本
        case EBCDIC = "EBCDIC"
        
        /// 启用API保护
        case ENABLE_API_ARMOR = "ENABLE_API_ARMOR"
        
        /// 启用批量原子写入
        case ENABLE_BATCH_ATOMIC_WRITE = "ENABLE_BATCH_ATOMIC_WRITE"
        
        /// 启用列元数据查询
        case ENABLE_COLUMN_METADATA = "ENABLE_COLUMN_METADATA"
        
        /// 启用CSV模块
        case ENABLE_CSV = "ENABLE_CSV"
        
        /// 启用DBPAGE虚拟表
        case ENABLE_DBPAGE_VTAB = "ENABLE_DBPAGE_VTAB"
        
        /// 启用DBSTAT虚拟表
        case ENABLE_DBSTAT_VTAB = "ENABLE_DBSTAT_VTAB"
        
        /// 启用或禁用FTS3模块
        case ENABLE_FTS3 = "ENABLE_FTS3"
        
        /// 启用FTS3_MATCHINFO函数
        case ENABLE_FTS3_MATCHINFO = "ENABLE_FTS3_MATCHINFO"
        
        /// 启用FTS3、FTS4和FTS5的JSON1函数
        case ENABLE_FTS3_PARENTHESIS = "ENABLE_FTS3_PARENTHESIS"
        
        /// 启用FTS3的标记器
        case ENABLE_FTS3_TOKENIZER = "ENABLE_FTS3_TOKENIZER"
        
        /// 启用或禁用FTS4模块
        case ENABLE_FTS4 = "ENABLE_FTS4"
        
        /// 启用FTS5模块
        case ENABLE_FTS5 = "ENABLE_FTS5"
        
        /// 启用Geopoly模块
        case ENABLE_GEOPOLY = "ENABLE_GEOPOLY"
        
        /// 启用或禁用JSON1模块
        case ENABLE_JSON1 = "ENABLE_JSON1"
        
        /// 启用锁定样式
        case ENABLE_LOCKING_STYLE = "ENABLE_LOCKING_STYLE"
        
        /// 启用预更新钩子
        case ENABLE_PREUPDATE_HOOK = "ENABLE_PREUPDATE_HOOK"
        
        /// 启用或禁用RTREE模块
        case ENABLE_RTREE = "ENABLE_RTREE"
        
        /// 启用会话模块
        case ENABLE_SESSION = "ENABLE_SESSION"
        
        /// 启用快照模块
        case ENABLE_SNAPSHOT = "ENABLE_SNAPSHOT"
        
        /// 启用SQL日志
        case ENABLE_SQLLOG = "ENABLE_SQLLOG"
        
        /// 启用STAT4扩展
        case ENABLE_STAT4 = "ENABLE_STAT4"
        
        /// 启用未知SQL函数
        case ENABLE_UNKNOWN_SQL_FUNCTION = "ENABLE_UNKNOWN_SQL_FUNCTION"
        
        /// 启用解锁通知机制
        case ENABLE_UNLOCK_NOTIFY = "ENABLE_UNLOCK_NOTIFY"
        
        /// 启用或禁用UPDATE和DELETE的LIMIT子句支持
        case ENABLE_UPDATE_DELETE_LIMIT = "ENABLE_UPDATE_DELETE_LIMIT"
        
        /// 启用SQLCipher的加密
        case HAS_CODEC = "HAS_CODEC"
        
        /// 启用或禁用SQLite码流
        case HAS_CODEC_RESTRICTED = "HAS_CODEC_RESTRICTED"
        
        /// 是否支持isnan()函数
        case HAVE_ISNAN = "HAVE_ISNAN"
        
        /// LIKE操作符是否不匹配BLOB类型
        case LIKE_DOESNT_MATCH_BLOBS = "LIKE_DOESNT_MATCH_BLOBS"
        
        /// 每个数据库连接的最大附加数据库数量
        case MAX_ATTACHED = "MAX_ATTACHED"
        
        /// 最大列数
        case MAX_COLUMN = "MAX_COLUMN"
        
        /// 最大SQL语句长度
        case MAX_LENGTH = "MAX_LENGTH"
        
        /// 最大LIKE模式长度
        case MAX_LIKE_PATTERN_LENGTH = "MAX_LIKE_PATTERN_LENGTH"
        
        /// 最大内存映射大小
        case MAX_MMAP_SIZE = "MAX_MMAP_SIZE"
        
        /// 最大页面数
        case MAX_PAGE_COUNT = "MAX_PAGE_COUNT"
        
        /// 重试打开数据库时最大的次数
        case MAX_SCHEMA_RETRY = "MAX_SCHEMA_RETRY"
        
        /// 触发器的最大嵌套深度
        case MAX_TRIGGER_DEPTH = "MAX_TRIGGER_DEPTH"
        
        /// 最大变量数
        case MAX_VARIABLE_NUMBER = "MAX_VARIABLE_NUMBER"
        
        /// 最大工作线程数
        case MAX_WORKER_THREADS = "MAX_WORKER_THREADS"
        
        /// 是否省略自动重置
        case OMIT_AUTORESET = "OMIT_AUTORESET"
        
        /// 是否省略加载扩展
        case OMIT_LOAD_EXTENSION = "OMIT_LOAD_EXTENSION"
        
        /// 启用安全删除模式
        case SECURE_DELETE = "SECURE_DELETE"
        
        /// 设置排序器PMA的大小
        case SORTER_PMASZ = "SORTER_PMASZ"
        
        /// 启用或禁用Soundex函数
        case SOUNDEX = "SOUNDEX"
        
        /// 语句日志溢出阈值
        case STMTJRNL_SPILL = "STMTJRNL_SPILL"
        
        /// 临时数据库的存储类别
        case TEMP_STORE = "TEMP_STORE"
        
        /// SQLite线程安全选项
        case THREADSAFE = "THREADSAFE"
        
        /// 使用alloca()而不是malloc()来分配栈空间
        case USE_ALLOCA = "USE_ALLOCA"
        
        /// 是否启用URI支持
        case USE_URI = "USE_URI"
    }
}
