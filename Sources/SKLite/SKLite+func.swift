import SQLite3
import SKLiteWrapper

extension SKLite {
    /// 检查是否使用了某个编译选项
    @inlinable
    static func isCompileOptionUsed(option: CompileOption) -> Bool {
        return sqlite3_compileoption_used(option.rawValue.withCString { $0 }) == 1
    }
    
    /// 获取编译时选项列表
    public static func getCompileOptions() -> [CompileOption: String] {
        var optionIndex: Int32 = 0
        var options: [CompileOption: String] = [:]
        while let optionStr = sqlite3_compileoption_get(optionIndex) {
            let option = String(cString: optionStr)
            let components = option.split(separator: "=")
            if components.count == 2 {
                let key = String(components[0])
                let value = String(components[1])
                options[CompileOption(rawValue: key)!] = value
            } else {
                options[CompileOption(rawValue:option)!] = ""
            }
            optionIndex += 1
        }
        return options
    }
    
    public static func config(_ option: DbConfig, _ params: CVarArg...) -> SKLiteError {
        return withVaList(params) { pointer in
            return SKLiteError(rawValue: skliteConfig(option.rawValue, pointer))
        }
    }
    
    /**
     判断 SQL 语句是否完整。
     */
    public static func complete(_ sql: String) -> Bool {
        return sql.withCString { cString in
            return sqlite3_complete16(cString) == 1
        }
    }
    
    /**
     返回当前尚未释放的内存字节数（已经分配但尚未释放的内存）。
     */
    @inlinable
    public static func memoryUsed() -> Int64 {
        return sqlite3_memory_used()
    }
    
    /**
     返回自上次重置高水位标记以来[sqlite3_memory_used()]的最大值。
     你可以通过设置 resetFlag 参数来决定是否将高水位标记重置为当前内存使用量。
     memoryHighwater(0) 用来获取当前的内存高水位线（high-water mark），并且不重置它。
    */
    @inlinable
    public static func memoryHighwater(_ resetFlag: Int32) -> Int {
        return Int(sqlite3_memory_highwater(resetFlag))
    }
    
    @available(OSX 10.8, *)
    @inlinable
    public static func releaseMemory(_ amount: Int32) -> Int32 {
        return sqlite3_release_memory(amount)
    }
    
    @available(OSX 10.7, *)
    @inlinable
    public static func setSoftHeapLimit(_ limit: Int64) -> Int64 {
        return sqlite3_soft_heap_limit64(limit)
    }
    
    @available(OSX 10.10, iOS 8.2, *)
    @inlinable
    public static func errStr(_ errCode: Int32) -> String {
        return String(cString: sqlite3_errstr(errCode))
    }
    
    @discardableResult
    @inlinable
    public static func sleep(_ ms: Int32) -> Int {
        return Int(sqlite3_sleep(ms))
    }
    
    public static func status(_ op: SKLite.Status, reset: Bool = false) throws -> (Int, Int) {
        if #available(macOS 10.11, iOS 9.0, *) {
            var current: Int64 = 0
            var highwater: Int64 = 0
            let result = sqlite3_status64(op.rawValue, &current, &highwater, reset ? 1 : 0)
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result)
            }
            return (Int(current), Int(highwater))
        } else {
            var current: Int32 = 0
            var highwater: Int32 = 0
            let result = sqlite3_status(op.rawValue, &current, &highwater, reset ? 1 : 0)
            guard result == SQLITE_OK else {
                throw SKLite.SKLiteError(rawValue: result)
            }
            return (Int(current), Int(highwater))
        }
    }
}
