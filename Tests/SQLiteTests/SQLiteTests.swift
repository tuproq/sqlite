@testable import SQLite
import XCTest

final class SQLiteTests: XCTestCase {
    var database: SQLite!

    override func setUp() {
        super.setUp()

        database = SQLite()
        try! database.open()
    }

    override func tearDown() {
        database.close()

        super.tearDown()
    }

    func testBool() {
        // Arrange
        let boolTrue = true
        let boolFalse = false
        let boolNil: Bool? = nil
        let parameters: [Encodable?] = [boolTrue, boolFalse, boolNil]

        try! database.query(
            "CREATE TABLE test (boolTrue INTEGER NOT NULL, boolFalse INTEGER NOT NULL, boolNil INTEGER)"
        )
        try! database.query(
            "INSERT INTO test (boolTrue, boolFalse, boolNil) VALUES (?, ?, ?)",
            parameters: parameters
        )

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["boolTrue"] as? Int, 1)
        XCTAssertEqual(result.first?["boolFalse"] as? Int, 0)
        XCTAssertEqual(result.first?["boolNil"] as? Int, nil)
    }
}
