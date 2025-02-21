extension SKLite {
    public enum ColumnType: Int32 {
        case INTEGER = 1
        case FLOAT // 2
        case TEXT // 3 SQLITE_TEXT 和 SQLITE3_TEXT
        case BLOB // 4
        case NULL //5
    }
}
