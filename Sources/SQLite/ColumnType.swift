import SQLite3

public enum ColumnType {
    case blob
    case float
    case int
    case null
    case text

    public var rawValue: Int32 {
        switch self {
        case .blob: return SQLITE_BLOB
        case .float: return SQLITE_FLOAT
        case .int: return SQLITE_INTEGER
        case .null: return SQLITE_NULL
        case .text: return SQLITE3_TEXT
        }
    }

    public static func from(_ rawValue: Int32) -> Self {
        switch rawValue {
        case SQLITE_BLOB: return .blob
        case SQLITE_FLOAT: return .float
        case SQLITE_INTEGER: return .int
        case SQLITE_NULL: return .null
        default: return .text
        }
    }
}
