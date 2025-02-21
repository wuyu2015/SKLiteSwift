extension SKLite {
    public enum DbStatus: Int32 {
        case LOOKASIDE_USED = 0
        case CACHE_USED
        case SCHEMA_USED
        case STMT_USED
        case LOOKASIDE_HIT
        case LOOKASIDE_MISS_SIZE
        case LOOKASIDE_MISS_FULL
        case CACHE_HIT
        case CACHE_MISS
        case CACHE_WRITE
        case DEFERRED_FKS
        case CACHE_USED_SHARED
        case CACHE_SPILL
        
        static let MAX: Int32 = 12
    }
}
