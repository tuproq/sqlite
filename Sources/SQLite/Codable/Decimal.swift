import Foundation
#if os(Linux)
import CSQLite
#else
import SQLite3
#endif

extension Decimal: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try Double(truncating: self as NSNumber).encode(into: statement, column: column)
    }
}
