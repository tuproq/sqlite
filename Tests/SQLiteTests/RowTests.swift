@testable import SQLite
import XCTest

final class RowTests: XCTestCase {
    func testInit() {
        // Arrange
        let dataValueColumn = Column(name: "data", value: Data("data".utf8))
        let doubleValueColumn = Column(name: "double", value: 1.5)
        let stringValueColumn = Column(name: "string", value: "string")
        let nilValueColumn = Column(name: "int", value: nil)
        let columns = [dataValueColumn, doubleValueColumn, stringValueColumn, nilValueColumn]

        // Act
        let row = Row(columns: columns)

        // Assert
        XCTAssertEqual(row.columns, columns)
        XCTAssertEqual(row.description, "\(columns)")
    }
}
