struct Row: CustomStringConvertible {
    let columns: [Column]
    var description: String { columns.description }
}
