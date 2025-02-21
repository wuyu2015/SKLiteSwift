extension SKLite {
    public enum Conflict: Int32 {
        case ROLLBACK = 1
        case IGNORE
        case FAIL
        case ABORT
        case REPLACE
    }
}
