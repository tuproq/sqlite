#if os(Linux)
import CSQLite
#else
import SQLite3
#endif

extension Bool: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try (self ? 1 : 0).encode(into: statement, column: column)
    }
}
