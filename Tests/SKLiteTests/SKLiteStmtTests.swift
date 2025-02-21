import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteStmtTests: XCTestCase {
    
    func testInit1() throws {
        let db = try SKLite.Db()
        _ = try SKLite.Stmt(db: db, sql: "select 1 + 1")
    }
    
    func testInit2() throws {
        let db = try SKLite.Db()
        _ = try SKLite.Stmt(db: db, sql: "select ? + ?")
    }
    
    func testInit3() throws {
        let db = try SKLite.Db()
        XCTAssertThrowsError(try SKLite.Stmt(db: db, sql: "error sql")) { error in
            pr(error.localizedDescription)
            XCTAssertEqual(error as? SKLite.SKLiteError, SKLite.SKLiteError.ERROR)
        }
    }
    
    func testPrint_dataCount() throws {
        let stmt = try SKLite.Db().prepare(sql: "select 1 + 1")
        pr(stmt.dataCount)
    }
    
    func testPrintSql1() throws {
        let sql = "select 1 + 1"
        let stmt = try SKLite.Db().prepare(sql: sql)
        XCTAssertEqual(stmt.sql, sql)
        pr(stmt.sql)
    }
    
    func testPrintSql2() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        XCTAssertEqual(stmt.sql, sql)
        pr(stmt.sql)
    }
    
    func testPrintExpandedSql1() throws {
        let sql = "select 1 + 1"
        let stmt = try SKLite.Db().prepare(sql: sql)
        XCTAssertEqual(stmt.expandedSql, sql)
        pr(stmt.expandedSql)
    }
    
    func testPrintExpandedSql2() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        XCTAssertEqual(stmt.expandedSql, "select NULL + NULL")
        pr(stmt.expandedSql)
    }
    
    func testPrintExpandedSql3() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindInt(index: 1, value: 1)
            .bindInt(index: 2, value: 2)
        XCTAssertEqual(stmt.expandedSql, "select 1 + 2")
        pr(stmt.expandedSql)
    }
    
    func testBindInt() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindInt(index: 1, value: 1)
            .bindInt(index: 2, value: 2)
            .step()
        XCTAssertEqual(stmt.getInt(index: 0), 3)
    }
    
    func testBindDouble() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindDouble(index: 1, value: 1.1)
            .bindDouble(index: 2, value: 2.1)
            .step()
        XCTAssertEqual(stmt.getDouble(index: 0), 3.2)
    }
    
    func testBindString() throws {
        let sql = "select ? || ' ' || ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindString(index: 1, value: "Hello")
            .bindString(index: 2, value: "world!")
            .step()
        XCTAssertEqual(stmt.getString(index: 0), "Hello world!")
    }
    
    func testBindBlob() throws {
        let sql = "select ?"
        let blob: [UInt8] = [1, 2, 3, 4]
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindBlob(index: 1, value: blob)
            .step()
        if let p = stmt.getBlob(index: 0) {
            let sz = stmt.getBlobCount(index: 0)
            XCTAssertEqual(sz, 4)
            let buf = UnsafeRawBufferPointer(start: p, count: sz)
            let arr = Array(buf)
            XCTAssertEqual(arr, blob)
            pr(arr)
        }
    }
    
    func testBindZeroBlob() throws {
        let sql = "select ?"
        let sz = 128
        let blob: [UInt8] = Array(repeating: 0, count: sz)
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindZeroBlob(index: 1, count: sz)
            .step()
        if let p = stmt.getBlob(index: 0) {
            XCTAssertEqual(stmt.getBlobCount(index: 0), sz)
            let buf = UnsafeRawBufferPointer(start: p, count: sz)
            let arr = Array(buf)
            XCTAssertEqual(arr, blob)
            pr(arr)
        }
    }
    
    func testClearBindings() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindInt(index: 1, value: 1)
            .bindInt(index: 2, value: 2)
        XCTAssertEqual(stmt.expandedSql, "select 1 + 2")
        try stmt.clearBindings()
        XCTAssertEqual(stmt.expandedSql, "select NULL + NULL")
    }
    
    func testReset() throws {
        let sql = "select ? + ?"
        let stmt = try SKLite.Db().prepare(sql: sql)
        try stmt.bindInt(index: 1, value: 1)
            .bindInt(index: 2, value: 2)
            .step()
        XCTAssertEqual(stmt.getInt(index: 0), 3)
        
        stmt.reset() // reset() 前不能重新 bind
        
        try stmt.bindInt(index: 1, value: 3)
            .bindInt(index: 2, value: 4)
            .step()
        XCTAssertEqual(stmt.getInt(index: 0), 7)
    }
}
