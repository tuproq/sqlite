#if os(Linux)
import CSQLiteLinux
#else
import CSQLiteDarwin
#endif

extension FixedWidthInteger {
    public init(statement: Statement, column: Int32) throws {
        self = numericCast(sqlite3_column_int64(statement.handle, column))
    }

    public func encode(into statement: Statement, column: Int32) throws {
        let code = sqlite3_bind_int64(statement.handle, column, Int64(self))
        try assert(handle: statement.handle, code: code)
    }
}

extension Int: Codable {}
extension Int8: Codable {}
extension Int16: Codable {}
extension Int32: Codable {}
extension Int64: Codable {}
extension UInt: Codable {}
extension UInt8: Codable {}
extension UInt16: Codable {}
extension UInt32: Codable {}
extension UInt64: Codable {}
