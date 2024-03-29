import Foundation

extension UUID: SQLiteEncodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try uuidString.encode(into: statement, column: column)
    }
}
