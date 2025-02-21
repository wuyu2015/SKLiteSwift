import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteLimitTests: XCTestCase {
    
    func testPrintLimit() throws {
        let db = try SKLite.open()
        pr("LENGTH = \(SKLite.limit(db, limit: .LENGTH))")
        pr("SQL_LENGTH = \(SKLite.limit(db, limit: .SQL_LENGTH))")
        pr("COLUMN = \(SKLite.limit(db, limit: .COLUMN))")
        pr("EXPR_DEPTH = \(SKLite.limit(db, limit: .EXPR_DEPTH))")
        pr("COMPOUND_SELECT = \(SKLite.limit(db, limit: .COMPOUND_SELECT))")
        pr("VDBE_OP = \(SKLite.limit(db, limit: .VDBE_OP))")
        pr("FUNCTION_ARG = \(SKLite.limit(db, limit: .FUNCTION_ARG))")
        pr("ATTACHED = \(SKLite.limit(db, limit: .ATTACHED))")
        pr("LIKE_PATTERN_LENGTH = \(SKLite.limit(db, limit: .LIKE_PATTERN_LENGTH))")
        pr("VARIABLE_NUMBER = \(SKLite.limit(db, limit: .VARIABLE_NUMBER))")
        pr("TRIGGER_DEPTH = \(SKLite.limit(db, limit: .TRIGGER_DEPTH))")
        pr("WORKER_THREADS = \(SKLite.limit(db, limit: .WORKER_THREADS))")
        try SKLite.close(db)
    }
    
    func testSetLimit() throws {
        let db = try SKLite.open()
        let n: Int32 = 3
        var newValue: Int32
        
        SKLite.setLimit(db, limit: .LENGTH, newValue: n)
        newValue = SKLite.limit(db, limit: .LENGTH)
        XCTAssertEqual(newValue, n)
        pr("LENGTH = (newValue))")

        SKLite.setLimit(db, limit: .SQL_LENGTH, newValue: n)
        newValue = SKLite.limit(db, limit: .SQL_LENGTH)
        XCTAssertEqual(newValue, n)
        pr("SQL_LENGTH = (newValue))")

        SKLite.setLimit(db, limit: .COLUMN, newValue: n)
        newValue = SKLite.limit(db, limit: .COLUMN)
        XCTAssertEqual(newValue, n)
        pr("COLUMN = (newValue))")

        SKLite.setLimit(db, limit: .EXPR_DEPTH, newValue: n)
        newValue = SKLite.limit(db, limit: .EXPR_DEPTH)
        XCTAssertEqual(newValue, n)
        pr("EXPR_DEPTH = (newValue))")

        SKLite.setLimit(db, limit: .COMPOUND_SELECT, newValue: n)
        newValue = SKLite.limit(db, limit: .COMPOUND_SELECT)
        XCTAssertEqual(newValue, n)
        pr("COMPOUND_SELECT = (newValue))")

        SKLite.setLimit(db, limit: .VDBE_OP, newValue: n)
        newValue = SKLite.limit(db, limit: .VDBE_OP)
        XCTAssertEqual(newValue, n)
        pr("VDBE_OP = (newValue))")

        SKLite.setLimit(db, limit: .FUNCTION_ARG, newValue: n)
        newValue = SKLite.limit(db, limit: .FUNCTION_ARG)
        XCTAssertEqual(newValue, n)
        pr("FUNCTION_ARG = (newValue))")

        SKLite.setLimit(db, limit: .ATTACHED, newValue: n)
        newValue = SKLite.limit(db, limit: .ATTACHED)
        XCTAssertEqual(newValue, n)
        pr("ATTACHED = (newValue))")

        SKLite.setLimit(db, limit: .LIKE_PATTERN_LENGTH, newValue: n)
        newValue = SKLite.limit(db, limit: .LIKE_PATTERN_LENGTH)
        XCTAssertEqual(newValue, n)
        pr("LIKE_PATTERN_LENGTH = (newValue))")

        SKLite.setLimit(db, limit: .VARIABLE_NUMBER, newValue: n)
        newValue = SKLite.limit(db, limit: .VARIABLE_NUMBER)
        XCTAssertEqual(newValue, n)
        pr("VARIABLE_NUMBER = (newValue))")

        SKLite.setLimit(db, limit: .TRIGGER_DEPTH, newValue: n)
        newValue = SKLite.limit(db, limit: .TRIGGER_DEPTH)
        XCTAssertEqual(newValue, n)
        pr("TRIGGER_DEPTH = (newValue))")

        SKLite.setLimit(db, limit: .WORKER_THREADS, newValue: n)
        newValue = SKLite.limit(db, limit: .WORKER_THREADS)
        XCTAssertEqual(newValue, n)
        pr("WORKER_THREADS = (newValue))")
        
        try SKLite.close(db)
    }
}
