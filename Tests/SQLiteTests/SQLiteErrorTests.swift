@testable import SQLite
import XCTest

final class SQLiteErrorTests: XCTestCase {
    func testInit() {
        // Arrange
        let code: Int32 = -1
        let reason = "Unknown error"

        // Act
        var error = SQLiteError(code: code, reason: reason)

        // Assert
        XCTAssertEqual(error.code, code)
        XCTAssertEqual(error.reason, reason)
        XCTAssertEqual(error.description, "[\(code)] \(reason)")

        // Act
        error = SQLiteError(code: code)

        // Assert
        XCTAssertEqual(error.code, code)
        XCTAssertEqual(error.reason, reason)
        XCTAssertEqual(error.description, "[\(code)] \(reason)")
    }

    func testReasons() {
        // Assert
        XCTAssertEqual(SQLiteError.Reason.invalidColumnValue.message, "Invalid column value")
        XCTAssertEqual(SQLiteError.Reason.unexpectedNilColumnName.message, "Unexpected nil column name")
        XCTAssertEqual(SQLiteError.Reason.unexpectedNilColumnValue.message, "Unexpected nil column value")
        XCTAssertEqual(SQLiteError.Reason.unknown.message, "Unknown error")
    }
}
