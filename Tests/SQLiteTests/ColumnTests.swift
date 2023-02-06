@testable import SQLite
import XCTest

final class ColumnTests: XCTestCase {
    func testInit() {
        // Arrange
        let name = "name"
        let dataValue = Data("data".utf8)
        let doubleValue = 1.5
        let stringValue = "string"
        let nilValue: Int? = nil

        // Act
        let dataValueColumn = Column(name: name, value: dataValue)
        let doubleValueColumn = Column(name: name, value: doubleValue)
        let stringValueColumn = Column(name: name, value: stringValue)
        let nilValueColumn = Column(name: name, value: nilValue)

        // Assert
        XCTAssertEqual(dataValueColumn, doubleValueColumn)
        XCTAssertEqual(doubleValueColumn, stringValueColumn)
        XCTAssertEqual(stringValueColumn, nilValueColumn)

        XCTAssertEqual(dataValueColumn.name, name)
        XCTAssertEqual(dataValueColumn.value as? Data, dataValue)
        XCTAssertEqual(dataValueColumn.description, "\(name): \(dataValue)")

        XCTAssertEqual(doubleValueColumn.name, name)
        XCTAssertEqual(doubleValueColumn.value as? Double, doubleValue)
        XCTAssertEqual(doubleValueColumn.description, "\(name): \(doubleValue)")

        XCTAssertEqual(stringValueColumn.name, name)
        XCTAssertEqual(stringValueColumn.value as? String, stringValue)
        XCTAssertEqual(stringValueColumn.description, "\(name): \(stringValue)")

        XCTAssertEqual(nilValueColumn.name, name)
        XCTAssertEqual(nilValueColumn.value as? Int, nilValue)
        XCTAssertEqual(nilValueColumn.description, "\(name): nil")
    }
}
