import SQLite3

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

func error(code: Int32 = SQLITE_ERROR, reason: SQLiteError.Reason) -> SQLiteError {
    error(code: code, reason: reason.message)
}

func error(code: Int32 = SQLITE_ERROR, reason: String) -> SQLiteError {
    SQLiteError(code: code, reason: reason)
}

func error(code: Int32 = SQLITE_ERROR) -> SQLiteError {
    SQLiteError(code: code)
}

func lastErrorReason(handle: OpaquePointer?) -> String? {
    if let cString = sqlite3_errmsg(handle) {
        return String(cString: cString)
    }

    return nil
}

func assert(handle: OpaquePointer? = nil, code: Int32) throws {
    if code != SQLITE_OK {
        if let reason = lastErrorReason(handle: handle) {
            throw error(code: code, reason: reason)
        } else {
            throw error(code: code)
        }
    }
}
