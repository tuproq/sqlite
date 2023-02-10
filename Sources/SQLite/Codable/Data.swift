import Foundation
import SQLite3

extension Data: Codable {
    public init(statement: Statement, column: Int32) throws {
        let length = sqlite3_column_bytes(statement.handle, column)

        if let bytes = sqlite3_column_blob(statement.handle, column) {
            self = .init(bytes: bytes, count: Int(length))
        } else {
            throw error(reason: .unexpectedNilColumnValue)
        }
    }

    public func encode(into statement: Statement, column: Int32) throws {
        let code = withUnsafeBytes { pointer in
            sqlite3_bind_blob(statement.handle, column, pointer.baseAddress, Int32(count), SQLITE_TRANSIENT)
        }

        try assert(handle: statement.handle, code: code)
    }
}
