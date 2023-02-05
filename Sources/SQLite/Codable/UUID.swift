import Foundation
import SQLite3

extension UUID: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try uuidString.encode(into: statement, column: column)
    }
}
