import Foundation
import Logging
import SQLite3

let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

public final class SQLite {
    public let logger: Logger
    public var lastInsertRowID: Int { Int(sqlite3_last_insert_rowid(handle)) }
    private(set) var handle: OpaquePointer?

    public init(logger: Logger = .init(label: "dev.tuproq.sqlite")) {
        self.logger = logger
    }

    public func open(path: String = ":memory:", options: Options = [.create, .fullMutex, .readWrite]) throws {
        close()
        let code = sqlite3_open_v2(path, &handle, options.rawValue, nil)

        defer {
            if code != SQLITE_OK {
                close()
            }
        }

        try assert(handle: handle, code: code)
        logger.info("Database opened at \(path)")
    }

    public func close() {
        guard let handle = handle else { return }
        sqlite3_close(handle)
        self.handle = nil
        logger.info("Database closed")
    }

    @discardableResult
    public func query(_ query: String, parameters: Encodable?...) throws -> [[String: Decodable?]] {
        try self.query(query, parameters: parameters)
    }

    @discardableResult
    public func query(_ query: String, parameters: [Encodable?]) throws -> [[String: Decodable?]] {
        let statement = try Statement(query: query, database: self)
        try statement.bind(parameters)
        var result = [[String: Decodable?]]()

        do {
            while let row = try statement.row() {
                var dictionary = [String: Decodable?]()

                for column in row.columns {
                    dictionary[column.name] = column.value
                }

                result.append(dictionary)
            }

            logger.info("\(query)")
        } catch {
            logger.error("\(error)")
            throw error
        }

        return result
    }
}

extension SQLite {
    public struct Options: OptionSet {
        public static let create = Options(rawValue: SQLITE_OPEN_CREATE)
        public static let fullMutex = Options(rawValue: SQLITE_OPEN_FULLMUTEX)
        public static let noMutex = Options(rawValue: SQLITE_OPEN_NOMUTEX)
        public static let readOnly = Options(rawValue: SQLITE_OPEN_READONLY)
        public static let readWrite = Options(rawValue: SQLITE_OPEN_READWRITE)

        public let rawValue: Int32

        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
    }
}
