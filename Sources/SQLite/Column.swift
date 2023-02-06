struct Column: CustomStringConvertible, Equatable {
    let name: String
    let value: Decodable?
    var description: String { "\(name): \(value?.description ?? "nil")" }

    static func == (lhs: Column, rhs: Column) -> Bool {
        lhs.name == rhs.name
    }
}
