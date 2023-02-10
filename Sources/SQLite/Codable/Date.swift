import Foundation
import SQLite3

extension Date: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try timeIntervalSince1970.encode(into: statement, column: column)
    }
}
