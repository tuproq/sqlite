public struct Row: CustomStringConvertible {
    public let columns: [Column]
    public var description: String { columns.description }
}
