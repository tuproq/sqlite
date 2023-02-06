public struct SQLiteError: CustomStringConvertible, Error {
    public let code: Int32
    public let reason: String
    public var description: String { "[\(code)] \(reason)" }

    init(code: Int32, reason: String = Reason.unknown.message) {
        self.code = code
        self.reason = reason
    }
}

extension SQLiteError {
    enum Reason {
        case invalidColumnValue
        case unexpectedNilColumnName
        case unexpectedNilColumnValue
        case unknown

        var message: String {
            switch self {
            case .invalidColumnValue: return "Invalid column value"
            case .unexpectedNilColumnName: return "Unexpected nil column name"
            case .unexpectedNilColumnValue: return "Unexpected nil column value"
            case .unknown: return "Unknown error"
            }
        }
    }
}
