extension SKLite {
    public enum Config: Int32 {
        /**
         SQLITE_CONFIG_SINGLETHREAD：配置SQLite为单线程模式。
         SQLite不支持单线程行为，如果使用SQLITE_CONFIG_SINGLETHREAD配置选项调用sqlite3_config()，则会返回SQLITE_MISUSE
         */
         // case SINGLETHREAD = 1

        /**
         SQLITE_CONFIG_MULTITHREAD：配置SQLite为多线程模式，禁用数据库连接和预处理语句对象的互斥锁。
         没有参数
         将线程模式设置为多线程。换句话说，它禁用了数据库连接和预编译语句对象上的互斥体。
         应用程序负责串行访问数据库连接和预编译语句。
         但其他互斥体仍然启用，因此只要没有两个线程同时尝试使用相同的数据库连接，SQLite就可以在多线程环境中安全使用。
         如果SQLite使用编译时选项SQLITE_THREADSAFE | SQLITE_THREADSAFE = 0编译，则无法设置多线程线程模式，如果使用SQLITE_CONFIG_MULTITHREAD配置选项调用sqlite3_config()，则会返回SQLITE_ERROR。
         */
        case MULTITHREAD = 2
        
        /**
         SQLITE_CONFIG_SERIALIZED：配置SQLite为串行化模式，启用所有互斥锁。
         没有参数
         将线程模式设置为Serialized。换句话说，此选项启用了所有互斥体，包括递归互斥体在数据库连接和预编译语句对象上。
         在此模式下（在SQLite使用SQLITE_THREADSAFE = 1编译时默认情况下），SQLite库本身将序列化对数据库连接和预编译语句的访问，以便应用程序可以在不同的线程中同时使用相同的数据库连接或相同的预编译语句。
         如果SQLite使用编译时选项SQLITE_THREADSAFE | SQLITE_THREADSAFE = 0编译，则无法设置Serialized线程模式，如果使用SQLITE_CONFIG_SERIALIZED配置选项调用sqlite3_config()，则会返回SQLITE_ERROR。
         */
        case SERIALIZED = 3
        
        /**
         SQLITE_CONFIG_MALLOC：配置SQLite使用自定义的内存分配器。
         单参数：指向sqlite3_mem_methods结构的指针
         SQLITE_CONFIG_MALLOC选项接受一个参数，该参数是指向sqlite3_mem_methods结构实例的指针。该参数指定要在SQLite中使用的低级内存分配例程，以替代内置于SQLite中的内存分配例程。
         在sqlite3_config()调用返回之前，SQLite会将sqlite3_mem_methods结构的内容的私有副本制作出来。
         */
        case MALLOC = 4

        /**
         SQLITE_CONFIG_GETMALLOC：获取当前定义的内存分配器。
         单参数：指向sqlite3_mem_methods结构的指针
         SQLITE_CONFIG_GETMALLOC选项接受一个参数，该参数是指向sqlite3_mem_methods结构实例的指针。sqlite3_mem_methods结构被填充为当前定义的内存分配例程。
         此选项可用于使用模拟内存分配失败或跟踪内存使用情况等包装器重载默认内存分配例程。
        */
        case GETMALLOC = 5

        /**
         SQLITE_CONFIG_SCRATCH：配置SQLite使用临时内存空间。
         不再使用
        */
        // case SCRATCH = 6
        
        /**
         SQLITE_CONFIG_PAGECACHE：配置SQLite使用页面缓存。
         三个参数：void*, int sz, int N
         SQLITE_CONFIG_PAGECACHE选项指定SQLite可以在默认页面缓存实现中使用的内存池。
         如果使用SQLITE_CONFIG_PCACHE2加载应用程序定义的页面缓存实现，则此配置选项是无操作的。
         SQLITE_CONFIG_PAGECACHE有三个参数：指向8字节对齐内存的指针（pMem）、每个页面缓存行的大小（sz）和缓存行的数量（N）。
         sz参数应该是最大数据库页面的大小（512到65536之间的2的幂），再加上每个页面标题的一些额外字节。通过SQLITE_CONFIG_PCACHE_HDRSZ可以确定页面标题所需的额外字节的数量。
         sz参数比必要的更大无害，除了浪费内存之外，如果pMem参数不是NULL指针，则SQLite将努力使用提供的内存来满足页面缓存需要，如果页面缓存行大于sz字节，或者pMem缓冲区已耗尽，则会回退到sqlite3_malloc()。
         如果pMem为NULL且N非零，则每个数据库连接都从sqlite3_malloc()进行初始块分配以获得页面缓存内存，如果N为正数，则为N个缓存行，如果N为负数，则为-1024*N字节，如果需要超出初始分配提供的页面缓存内存，则SQLite将单独针对每个额外的缓存行进行sqlite3_malloc()。
        */
        case PAGECACHE = 7

        /**
         SQLITE_CONFIG_HEAP：配置SQLite使用静态内存缓冲区。
         三个参数：void*, int nByte, int min
        */
        case HEAP = 8

        /**
         SQLITE_CONFIG_MEMSTATUS：启用或禁用内存分配统计。
         单参数：int类型
         SQLITE_CONFIG_MEMSTATUS选项接受一个int类型的参数，解释为布尔值，用于启用或禁用内存分配统计信息的收集。当禁用内存分配统计信息时，以下SQLite接口将变为非操作：sqlite3_memory_used()、sqlite3_memory_highwater()、sqlite3_soft_heap_limit64()、sqlite3_status64()。
         默认情况下，除非在编译时使用SQLITE_DEFAULT_MEMSTATUS = 0编译SQLite，否则会启用内存分配统计信息收集。
        */
        case MEMSTATUS = 9

        /**
         SQLITE_CONFIG_MUTEX：配置SQLite使用自定义的互斥锁。
         sqlite3_mutex_methods* 类型
         SQLITE_CONFIG_MUTEX选项接受一个参数，该参数是指向sqlite3_mutex_methods结构实例的指针。该参数指定要在SQLite中使用的低级互斥体例程，以替代内置于SQLite中的互斥体例程。SQLite在调用sqlite3_config()返回之前对sqlite3_mutex_methods结构的内容进行副本。
         如果SQLite使用编译时选项SQLITE_THREADSAFE | SQLITE_THREADSAFE = 0编译，则会从构建中省略整个互斥体子系统，因此调用SQLITE_CONFIG_MUTEX配置选项的sqlite3_config()将返回SQLITE_ERROR。
        */
        case MUTEX = 10

        /**
         SQLITE_CONFIG_GETMUTEX：获取当前定义的互斥锁。
         sqlite3_mutex_methods* 类型
         SQLITE_CONFIG_GETMUTEX选项接受一个参数，该参数是指向sqlite3_mutex_methods结构实例的指针。sqlite3_mutex_methods结构填充为当前定义的互斥体例程。
         此选项可用于使用用于性能分析或测试的包装器重载默认互斥体分配例程跟踪互斥体使用情况。如果SQLite使用编译时选项SQLITE_THREADSAFE | SQLITE_THREADSAFE = 0编译，则会从构建中省略整个互斥体子系统，因此调用SQLITE_CONFIG_GETMUTEX配置选项的sqlite3_config()将返回SQLITE_ERROR。
        */
        case GETMUTEX = 11

        /**
         SQLITE_CONFIG_LOOKASIDE：设置默认的Lookaside内存大小。
         两个参数：int int
        */
        case LOOKASIDE = 13

        /**
         SQLITE_CONFIG_PCACHE2：配置自定义页面缓存实现。
         不执行任何操作
        */
        // case PCACHE = 14

        /**
         SQLITE_CONFIG_GETPCACHE2：获取当前定义的页面缓存实现。
         不执行任何操作
        */
        // case GETPCACHE = 15

        /**
         SQLITE_CONFIG_LOG：配置自定义日志器。
         不支持
        */
        // case LOG = 16
        
        /**
         SQLITE_CONFIG_URI：启用或禁用URI处理。
         boolean
        */
        case URI = 17
        
        /**
         SQLITE_CONFIG_PCACHE2
        */
        case PCACHE2 = 18

        /**
         SQLITE_CONFIG_GETPCACHE2
        */
        case GETPCACHE2 = 19

        /**
         SQLITE_CONFIG_COVERING_INDEX_SCAN：启用或禁用使用覆盖索引进行完整表扫描的优化。
         boolean
        */
        case COVERING_INDEX_SCAN = 20

        /**
         SQLITE_CONFIG_SQLLOG：配置自定义SQL日志记录器。
         xSqllog, void*
        */
        case SQLLOG = 21

        /**
         SQLITE_CONFIG_MMAP_SIZE：设置默认的mmap大小限制。
         sqlite3_int64, sqlite3_int64
        */
        case MMAP_SIZE = 22

        /**
         SQLITE_CONFIG_WIN32_HEAPSIZE：设置Windows下堆的最大大小。
         int nByte
        */
        case WIN32_HEAPSIZE = 23

        /**
         SQLITE_CONFIG_PCACHE_HDRSZ：获取页面缓存头部大小。
         int *psz
        */
        case PCACHE_HDRSZ = 24

        /**
         SQLITE_CONFIG_PMASZ：设置多线程排序器的最小PMA大小。
         unsigned int szPma
        */
        case PMASZ = 25

        /**
         SQLITE_CONFIG_STMTJRNL_SPILL：设置语句日志溢出阈值。
         int nByte
        */
        case STMTJRNL_SPILL = 26

        /**
         boolean
        */
        case SMALL_MALLOC = 27

        /**
         SQLITE_CONFIG_SORTERREF_SIZE：设置排序器参考大小阈值。
         int nByte
        */
        case SORTERREF_SIZE = 28

        /**
         SQLITE_CONFIG_MEMDB_MAXSIZE：设置内存数据库的最大大小。
         sqlite3_int64
        */
        case MEMDB_MAXSIZE = 29
    }
}
