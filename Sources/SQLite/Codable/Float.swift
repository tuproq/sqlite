extension Float: Encodable {
    public func encode(into statement: Statement, column: Int32) throws {
        try Double(self).encode(into: statement, column: column)
    }
}
