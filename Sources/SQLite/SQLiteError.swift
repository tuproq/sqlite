import SQLite3

public struct SQLiteError: CustomStringConvertible, Error {
    public let code: Int32
    public let reason: String
    public var description: String { "[\(code)] \(reason)" }

    init(code: Int32, reason: String? = nil) {
        self.code = code
        self.reason = reason ?? Reason.unknown.message
    }
}
