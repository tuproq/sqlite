public typealias Codable = Decodable & Encodable

public protocol Decodable: CustomStringConvertible, Swift.Decodable {
    init(statement: Statement, column: Int32) throws
}

public protocol Encodable: Swift.Encodable {
    func encode(into statement: Statement, column: Int32) throws
}
