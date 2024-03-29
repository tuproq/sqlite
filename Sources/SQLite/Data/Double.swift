import SQLite3

extension Double: SQLiteCodable {
    public init(statement: Statement, column: Int32) throws {
        self = .init(sqlite3_column_double(statement.handle, column))
    }

    public func encode(into statement: Statement, column: Int32) throws {
        let code = sqlite3_bind_double(statement.handle, column, self)
        try assert(handle: statement.handle, code: code)
    }
}
