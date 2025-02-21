import SQLite3

extension SKLite {
    public struct PrepareFlag: OptionSet {
        public let rawValue: Int32
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
        
        /// 这个标志告诉 SQLite 将预编译的 SQL 语句保存在缓存中，以便在多次执行相同语句时提高性能。如果使用此标志，SQLite 将尝试在内部缓存中查找已经准备好的相同 SQL 语句，从而避免重新解析和编译它们。
        public static let PERSISTENT = PrepareFlag(rawValue: SQLITE_PREPARE_PERSISTENT)
        
        /// 这个标志告诉 SQLite 在准备 SQL 语句时对其进行规范化。规范化可以消除语句中的不同形式，例如将字符串常量的引号标准化为单引号，以便更容易比较和缓存。这有助于提高查询的重用性和性能。
        public static let NORMALIZE = PrepareFlag(rawValue: SQLITE_PREPARE_NORMALIZE)
        
        /// 这个标志告诉 SQLite 在准备阶段不要解析虚拟表。虚拟表是一种特殊的表类型，可能在运行时动态改变结构。如果你确定你的 SQL 语句中不包含虚拟表，使用此标志可以提高性能，因为 SQLite 不会尝试解析虚拟表。
        public static let NO_VTAB = PrepareFlag(rawValue: SQLITE_PREPARE_NO_VTAB)
    }
}
