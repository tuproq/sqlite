import SQLite3

extension FixedWidthInteger {
    public init(statement: Statement, column: Int32) throws {
        self = numericCast(sqlite3_column_int64(statement.handle, column))
    }

    public func encode(into statement: Statement, column: Int32) throws {
        let code = sqlite3_bind_int64(statement.handle, column, Int64(self))
        try assert(handle: statement.handle, code: code)
    }
}

extension Int: SQLiteCodable {}
extension Int8: SQLiteCodable {}
extension Int16: SQLiteCodable {}
extension Int32: SQLiteCodable {}
extension Int64: SQLiteCodable {}
extension UInt: SQLiteCodable {}
extension UInt8: SQLiteCodable {}
extension UInt16: SQLiteCodable {}
extension UInt32: SQLiteCodable {}
extension UInt64: SQLiteCodable {}
