import Foundation
import SQLite3

extension Decimal: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try Double(truncating: self as NSNumber).encode(into: statement, column: column)
    }
}
