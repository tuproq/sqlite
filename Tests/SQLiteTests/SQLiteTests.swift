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

    func testData() {
        // Arrange
        let data = Data("data".utf8)
        let dataNil: Data? = nil
        let parameters: [Encodable?] = [data, dataNil]

        try! database.query("CREATE TABLE test (data BLOB NOT NULL, dataNil BLOB)")
        try! database.query("INSERT INTO test (data, dataNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["data"] as? Data, data)
        XCTAssertEqual(result.first?["dataNil"] as? Data, nil)
    }

    func testDate() {
        // Arrange
        let date = Date()
        let dateNil: Date? = nil
        let parameters: [Encodable?] = [date, dateNil]

        try! database.query("CREATE TABLE test (date REAL NOT NULL, dateNil REAL)")
        try! database.query("INSERT INTO test (date, dateNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["date"] as? Double, date.timeIntervalSince1970)
        XCTAssertEqual(result.first?["dateNil"] as? Double, nil)
    }

    func testDecimal() {
        // Arrange
        let decimal = Decimal(1.5)
        let decimalNil: Decimal? = nil
        let parameters: [Encodable?] = [decimal, decimalNil]

        try! database.query("CREATE TABLE test (decimal REAL NOT NULL, decimalNil REAL)")
        try! database.query("INSERT INTO test (decimal, decimalNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["decimal"] as? Double, Double(truncating: decimal as NSNumber))
        XCTAssertEqual(result.first?["decimalNil"] as? Double, nil)
    }

    func testDouble() {
        // Arrange
        let double = 2.5
        let doubleNil: Double? = nil
        let parameters: [Encodable?] = [double, doubleNil]

        try! database.query("CREATE TABLE test (double REAL NOT NULL, doubleNil REAL)")
        try! database.query("INSERT INTO test (double, doubleNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["double"] as? Double, double)
        XCTAssertEqual(result.first?["doubleNil"] as? Double, nil)
    }

    func testFloat() {
        // Arrange
        let float = Float(3.2)
        let floatNil: Float? = nil
        let parameters: [Encodable?] = [float, floatNil]

        try! database.query("CREATE TABLE test (float REAL NOT NULL, floatNil REAL)")
        try! database.query("INSERT INTO test (float, floatNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["float"] as? Double, Double(float))
        XCTAssertEqual(result.first?["floatNil"] as? Double, nil)
    }

    func testInt() {
        // Arrange
        let int = 3
        let intNil: Double? = nil
        let parameters: [Encodable?] = [int, intNil]

        try! database.query("CREATE TABLE test (int INTEGER NOT NULL, intNil INTEGER)")
        try! database.query("INSERT INTO test (int, intNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["int"] as? Int, int)
        XCTAssertEqual(result.first?["intNil"] as? Int, nil)
    }

    func testString() {
        // Arrange
        let string = "string"
        let stringNil: String? = nil
        let parameters: [Encodable?] = [string, stringNil]

        try! database.query("CREATE TABLE test (string TEXT NOT NULL, stringNil TEXT)")
        try! database.query("INSERT INTO test (string, stringNil) VALUES (?, ?)", parameters: parameters)

        // Act
        let result = try! database.query("SELECT * FROM test")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, parameters.count)
        XCTAssertEqual(result.first?["string"] as? String, string)
        XCTAssertEqual(result.first?["stringNil"] as? String, nil)
    }
}
