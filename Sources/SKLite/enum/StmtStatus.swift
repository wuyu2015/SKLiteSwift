extension SKLite {
    public enum StmtStatus: Int32 {
        case FULLSCAN_STEP = 1
        case SORT
        case AUTOINDEX
        case VM_STEP
        case REPREPARE
        case RUN
        case MEMUSED = 99
    }
}
