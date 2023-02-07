#if os(Linux)
import CSQLiteLinux
#else
import CSQLiteDarwin
#endif

extension String: Codable {
    public init(statement: Statement, column: Int32) throws {
        if let cString = sqlite3_column_text(statement.handle, column) {
            self = .init(cString: cString)
        } else {
            throw error(reason: .unexpectedNilColumnValue)
        }
    }

    public func encode(into statement: Statement, column: Int32) throws {
        let code = sqlite3_bind_text(statement.handle, column, self, Int32(utf8.count), SQLITE_TRANSIENT)
        try assert(handle: statement.handle, code: code)
    }
}
