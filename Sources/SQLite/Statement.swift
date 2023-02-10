import Foundation
import SQLite3

public struct Statement {
    public let query: String
    public let database: SQLite
    private(set) var handle: OpaquePointer?

    public init(query: String, database: SQLite) throws {
        self.query = query
        self.database = database
        try assert(code: sqlite3_prepare_v2(database.handle, query, -1, &handle, nil))
    }

    public func bind(_ parameters: [Encodable?]) throws {
        for (index, parameter) in parameters.enumerated() {
            try parameter?.encode(into: self, column: Int32(index + 1))
        }
    }

    func row() throws -> Row? {
        let code = sqlite3_step(handle)

        switch code {
        case SQLITE_ROW:
            var columns = [Column]()

            for index in 0..<sqlite3_column_count(handle) {
                let column = Column(name: try columnName(at: index), value: try columnValue(at: index))
                columns.append(column)
            }

            return Row(columns: columns)
        case SQLITE_DONE:
            let code = sqlite3_finalize(handle)

            if code != SQLITE_OK {
                if let lastErrorMessage = lastErrorReason(handle: handle) {
                    throw error(code: code, reason: lastErrorMessage)
                } else {
                    throw error(code: code)
                }
            }

            return nil
        default:
            if let lastErrorMessage = lastErrorReason(handle: handle) {
                throw error(code: code, reason: lastErrorMessage)
            } else {
                throw error(code: code)
            }
        }
    }

    private func columnName(at column: Int32) throws -> String {
        if let cString = sqlite3_column_name(handle, column) {
            return String(cString: cString)
        }

        throw error(reason: .unexpectedNilColumnName)
    }

    private func columnValue(at column: Int32) throws -> Decodable? {
        switch sqlite3_column_type(handle, column) {
        case SQLITE_BLOB: return try Data(statement: self, column: column)
        case SQLITE_FLOAT: return try Double(statement: self, column: column)
        case SQLITE_INTEGER: return try Int(statement: self, column: column)
        case SQLITE_NULL: return nil
        case SQLITE3_TEXT: return try String(statement: self, column: column)
        default: throw error(reason: .unexpectedNilColumnValue)
        }
    }
}
