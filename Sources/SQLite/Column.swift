public struct Column: CustomStringConvertible, Equatable {
    public let name: String
    public let value: Decodable?
    public var description: String { "\(name): \(value?.description ?? "nil")" }

    public static func == (lhs: Column, rhs: Column) -> Bool {
        lhs.name == rhs.name
    }
}
