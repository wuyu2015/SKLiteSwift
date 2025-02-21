extension SKLite {
    public enum ThreadSafeLevel: Int32 {
        /// 表示禁用互斥，SQLite 是非线程安全的。
        case unsafe = 0
        
        /// 表示启用多线程模式，SQLite 是线程安全的，但是只允许一个线程访问数据库。
        case singleThreaded = 1
        
        /// 表示启用序列化模式，SQLite 是线程安全的，并且允许多个线程同时访问数据库，但是只允许一个线程执行写操作。
        case multiThreaded = 2
    }
}
