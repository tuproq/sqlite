import Foundation
import SQLite3

extension Date: Encodable {
//    public init(statement: Statement, column: Int32) throws {
//        let value: Double
//
//        do {
//            value = try .init(statement: statement, column: column)
//        } catch {
//            do {
//                value = .init(try Int(statement: statement, column: column))
//            } catch {
//                throw error
//            }
//        }
//
//        self = .init(
//            timeIntervalSinceReferenceDate: round((value - Date.timeIntervalBetween1970AndReferenceDate) * 1e6) / 1e6
//        )
//    }

    public func encode(into statement: Statement, column: Int32) throws {
        try timeIntervalSince1970.encode(into: statement, column: column)
    }
}
