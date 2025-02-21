import SQLite3

extension SKLite {
    public struct Deserialize: OptionSet {
        public let rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        public static let FREEONCLOSE = OpenFlag(rawValue: SQLITE_DESERIALIZE_FREEONCLOSE)
        public static let RESIZEABLE = OpenFlag(rawValue: SQLITE_DESERIALIZE_RESIZEABLE)
        public static let READONLY = OpenFlag(rawValue: SQLITE_DESERIALIZE_READONLY)
    }
}
