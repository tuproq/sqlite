public typealias SQLiteCodable = SQLiteDecodable & SQLiteEncodable

public protocol SQLiteDecodable: CustomStringConvertible, Decodable {
    init(statement: Statement, column: Int32) throws
}

public protocol SQLiteEncodable: Encodable {
    func encode(into statement: Statement, column: Int32) throws
}
