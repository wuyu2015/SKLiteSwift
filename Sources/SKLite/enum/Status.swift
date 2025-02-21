extension SKLite {
    public enum Status: Int32 {
        case MEMORY_USED = 0
        case PAGECACHE_USED
        case PAGECACHE_OVERFLOW
        case SCRATCH_USED
        case SCRATCH_OVERFLOW
        case MALLOC_SIZE
        case PARSER_STACK
        case PAGECACHE_SIZE
        case SCRATCH_SIZE
        case MALLOC_COUNT
    }
}
