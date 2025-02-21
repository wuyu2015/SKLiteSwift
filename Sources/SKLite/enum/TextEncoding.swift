extension SKLite {
    public enum TextEncoding: Int32 {
        case UTF8 = 1
        case UTF16LE
        case UTF16BE
        case UTF16
        case ANY
        case UTF16_ALIGNED = 8
    }
}
