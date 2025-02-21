import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteDbStatusTests: XCTestCase {
    
    func testPrintDbStatus() throws {
        let db = try SKLite.open()
        pr("LOOKASIDE_USED = \(try SKLite.status(db: db, op: .LOOKASIDE_USED))")
        pr("CACHE_USED = \(try SKLite.status(db: db, op: .CACHE_USED))")
        pr("SCHEMA_USED = \(try SKLite.status(db: db, op: .SCHEMA_USED))")
        pr("STMT_USED = \(try SKLite.status(db: db, op: .STMT_USED))")
        pr("LOOKASIDE_HIT = \(try SKLite.status(db: db, op: .LOOKASIDE_HIT))")
        pr("LOOKASIDE_MISS_SIZE = \(try SKLite.status(db: db, op: .LOOKASIDE_MISS_SIZE))")
        pr("LOOKASIDE_MISS_FULL = \(try SKLite.status(db: db, op: .LOOKASIDE_MISS_FULL))")
        pr("CACHE_HIT = \(try SKLite.status(db: db, op: .CACHE_HIT))")
        pr("CACHE_MISS = \(try SKLite.status(db: db, op: .CACHE_MISS))")
        pr("CACHE_WRITE = \(try SKLite.status(db: db, op: .CACHE_WRITE))")
        pr("DEFERRED_FKS = \(try SKLite.status(db: db, op: .DEFERRED_FKS))")
        pr("CACHE_USED_SHARED = \(try SKLite.status(db: db, op: .CACHE_USED_SHARED))")
        pr("CACHE_SPILL = \(try SKLite.status(db: db, op: .CACHE_SPILL))")
        try SKLite.close(db)
    }
    
    func testDbStatusResetHighwater() throws {
        let db = try SKLite.open()
        var result: (current: Int32, highwater: Int32)
        
        result = try SKLite.status(db: db, op: .LOOKASIDE_USED, resetHighwater: true)
        pr("LOOKASIDE_USED = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .CACHE_USED, resetHighwater: true)
        pr("CACHE_USED = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .SCHEMA_USED, resetHighwater: true)
        pr("SCHEMA_USED = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .STMT_USED, resetHighwater: true)
        pr("STMT_USED = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .LOOKASIDE_HIT, resetHighwater: true)
        pr("LOOKASIDE_HIT = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .LOOKASIDE_MISS_SIZE, resetHighwater: true)
        pr("LOOKASIDE_MISS_SIZE = \(result)")
//        XCTAssertNotEqual(result.highwater, 0) // 不能 reset LOOKASIDE_MISS_SIZE

        result = try SKLite.status(db: db, op: .LOOKASIDE_MISS_FULL, resetHighwater: true)
        pr("LOOKASIDE_MISS_FULL = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .CACHE_HIT, resetHighwater: true)
        pr("CACHE_HIT = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .CACHE_MISS, resetHighwater: true)
        pr("CACHE_MISS = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .CACHE_WRITE, resetHighwater: true)
        pr("CACHE_WRITE = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .DEFERRED_FKS, resetHighwater: true)
        pr("DEFERRED_FKS = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .CACHE_USED_SHARED, resetHighwater: true)
        pr("CACHE_USED_SHARED = \(result)")
        XCTAssertEqual(result.highwater, 0)

        result = try SKLite.status(db: db, op: .CACHE_SPILL, resetHighwater: true)
        pr("CACHE_SPILL = \(result)")
        XCTAssertEqual(result.highwater, 0)
        
        try SKLite.close(db)
    }
}
