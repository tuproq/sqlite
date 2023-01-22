public struct SQLiteError: CustomStringConvertible, Error {
    public let code: Int32
    public let reason: String
    public var description: String { "Code: \(code), Reason: \(reason)" }
}
