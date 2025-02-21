extension SKLite {
    public enum IndexConstraint: Int32 {
        case EQ = 2
        case GT = 4
        case LE = 8
        case LT = 16
        case GE = 32
        case MATCH = 64
        case LIKE = 65
        case GLOB = 66
        case REGEXP = 67
        case NE = 68
        case ISNOT = 69
        case ISNOTNULL = 70
        case ISNULL = 71
        case IS = 72
        case FUNCTION = 150
    }
}
