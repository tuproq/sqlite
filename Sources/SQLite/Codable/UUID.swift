import Foundation
#if os(Linux)
import CSQLite
#else
import SQLite3
#endif

extension UUID: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try uuidString.encode(into: statement, column: column)
    }
}
