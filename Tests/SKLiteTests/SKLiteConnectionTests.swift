import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteConnectionTests: XCTestCase {
    
    func testFileName() throws {
        let dbMem = try SKLite.open()
        XCTAssertEqual(SKLite.fileName(db: dbMem, database: "not_exists"), nil)
        XCTAssertEqual(SKLite.fileName(db: dbMem, database: "main"), "")
        XCTAssertEqual(SKLite.fileName(db: dbMem), "")
        try SKLite.close(dbMem)
        
        let dbURL = SKLite.documentDirectoryURL.appendingPathComponent(randomDbName())
        let db = try SKLite.open(dbURL, flags: [.READWRITE, .CREATE])
        XCTAssertEqual(SKLite.fileName(db: db, database: "not_exists"), nil)
        XCTAssertEqual(SKLite.fileName(db: db, database: "main"), dbURL.path)
        XCTAssertEqual(SKLite.fileName(db: db), dbURL.path)
        pr(dbURL.path)
        try SKLite.close(db)
        try SKLite.remove(dbURL)
    }
    
    func testReadable1() throws {
        let dbURL = SKLite.documentDirectoryURL.appendingPathComponent(randomDbName())
        let db = try SKLite.open(dbURL, flags: [.READWRITE, .CREATE])
        XCTAssertFalse(SKLite.readable(db: db, database: "not_exists"))
        XCTAssertTrue(SKLite.readable(db: db, database: "main"))
        XCTAssertTrue(SKLite.readable(db: db))
        try SKLite.close(db)
        try SKLite.remove(dbURL)
    }
    
    func testReadable2() throws {
        let dbURL = SKLite.documentDirectoryURL.appendingPathComponent(randomDbName())
        try SKLite.touch(dbURL)
        let db = try SKLite.open(dbURL, flags: [.READONLY])
        XCTAssertFalse(SKLite.readable(db: db, database: "not_exists"))
        XCTAssertTrue(SKLite.readable(db: db, database: "main"))
        XCTAssertTrue(SKLite.readable(db: db))
        try SKLite.close(db)
        try SKLite.remove(dbURL)
    }
    
    func testWritable() throws {
        let dbURL = SKLite.documentDirectoryURL.appendingPathComponent(randomDbName())
        let db = try SKLite.open(dbURL, flags: [.READWRITE, .CREATE])
        XCTAssertFalse(SKLite.writable(db: db, database: "not_exists"))
        XCTAssertTrue(SKLite.writable(db: db, database: "main"))
        XCTAssertTrue(SKLite.writable(db: db))
        try SKLite.close(db)
        try SKLite.remove(dbURL)
    }
    
    func testReadOnly() throws {
        let dbURL = SKLite.documentDirectoryURL.appendingPathComponent(randomDbName())
        try SKLite.touch(dbURL)
        let db = try SKLite.open(dbURL, flags: [.READONLY])
        XCTAssertFalse(SKLite.readOnly(db: db, database: "not_exists"))
        XCTAssertTrue(SKLite.readOnly(db: db, database: "main"))
        XCTAssertTrue(SKLite.readOnly(db: db))
        try SKLite.close(db)
        try SKLite.remove(dbURL)
    }
    
    func testAutoCommit1() throws {
        let db = try SKLite.open()
        XCTAssertTrue(SKLite.autoCommit(db))
        try SKLite.close(db)
    }
    
    func testAutoCommit2() throws {
        let dbURL = SKLite.documentDirectoryURL.appendingPathComponent(randomDbName())
        try SKLite.touch(dbURL)
        let db = try SKLite.open()
        XCTAssertTrue(SKLite.autoCommit(db))
        try SKLite.close(db)
        try SKLite.remove(dbURL)
    }
    
    func testExec() throws {
        let db = try SKLite.open()
        try SKLite.exec(db, sql: "select 1 + 1")
        try SKLite.close(db)
    }
}
