import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteStatementTests: XCTestCase {
    func testPrepare() throws {
        let conn = try SKLite.open()
        let sql = "select 1 + 1"
        let stmt = try SKLite.prepare(conn, sql: sql)
        XCTAssertEqual(SKLite.sql(stmt: stmt), sql)
        
        XCTAssertTrue(try SKLite.step(stmt))
        XCTAssertEqual(SKLite.getInt(stmt, index: 0), 2)
        
        SKLite.reset(stmt)
        XCTAssertTrue(try SKLite.step(stmt))
        XCTAssertEqual(SKLite.getInt(stmt, index: 0), 2)
        
        SKLite.reset(stmt)
        XCTAssertTrue(try SKLite.step(stmt))
        XCTAssertEqual(SKLite.getInt(stmt, index: 0), 2)
        
        SKLite.reset(stmt)
        XCTAssertTrue(try SKLite.step(stmt))
        XCTAssertEqual(SKLite.getInt(stmt, index: 0), 2)
        
        SKLite.reset(stmt)
        XCTAssertTrue(try SKLite.step(stmt))
        XCTAssertEqual(SKLite.getInt(stmt, index: 0), 2)
        
        try SKLite.finalize(stmt)
        
        try SKLite.close(conn)
        XCTAssertThrowsError(try SKLite.close(conn)) { error in
            XCTAssertEqual(error as? SKLite.SKLiteError, SKLite.SKLiteError.MISUSE)
        }
    }
    
    func testPrepareWithError() throws {
        let conn = try SKLite.open()
        XCTAssertThrowsError(try SKLite.prepare(conn, sql: "errorselect 1 + 1")) { error in
            pr(error.localizedDescription)
            XCTAssertEqual(error as? SKLite.SKLiteError, SKLite.SKLiteError.ERROR)
        }
        try SKLite.close(conn)
    }
    
    func testSql() throws {
        let conn = try SKLite.open()
        let stmt = try SKLite.prepare(conn, sql: "select 1 + 1; error")
        XCTAssertEqual(SKLite.sql(stmt: stmt), "select 1 + 1;")
        try SKLite.finalize(stmt)
        try SKLite.close(conn)
    }
    
    func testExpandedSql() throws {
        let conn = try SKLite.open()
        let sql = "select 1 + 1"
        let stmt = try SKLite.prepare(conn, sql: sql)
        XCTAssertEqual(SKLite.expandedSql(stmt: stmt), sql)
        try SKLite.finalize(stmt)
        try SKLite.close(conn)
    }
    
    func testReadOnly() throws {
        if #available(OSX 10.15, iOS 13.0, *) {
            let conn = try SKLite.open()
            
            let stmt1 = try SKLite.prepare(conn, sql: "select 1 + 1")
            XCTAssertTrue(SKLite.readOnly(stmt: stmt1))
            try SKLite.finalize(stmt1)
            
            let stmt2 = try SKLite.prepare(conn, sql: "insert into tbl(a) values (1)")
            XCTAssertFalse(SKLite.readOnly(stmt: stmt2))
            try SKLite.finalize(stmt2)
            
            try SKLite.close(conn)
        }
    }
    
    func testIsExplain() throws {
        if #available(OSX 10.15, iOS 13.0, *) {
            let conn = try SKLite.open()
            let sql = "EXPLAIN SELECT * FROM sqlite_master;"
            let stmt = try SKLite.prepare(conn, sql: sql)
            XCTAssertTrue(SKLite.isExplain(stmt: stmt))
            try SKLite.step(stmt)
            try SKLite.finalize(stmt)
            try SKLite.close(conn)
        }
    }
    
    func testIsExplainQueryPlan() throws {
        if #available(OSX 10.15, iOS 13.0, *) {
            let conn = try SKLite.open()
            let sql = "EXPLAIN QUERY PLAN SELECT * FROM sqlite_master;"
            let stmt = try SKLite.prepare(conn, sql: sql)
            XCTAssertTrue(SKLite.isExplainQueryPlan(stmt: stmt))
            try SKLite.step(stmt)
            try SKLite.finalize(stmt)
            try SKLite.close(conn)
        }
    }
    
    func testDataCount() throws {
        let conn = try SKLite.open()
        let sql = "select 1 + 1"
        let stmt = try SKLite.prepare(conn, sql: sql)
        XCTAssertEqual(SKLite.dataCount(stmt: stmt), 0)
        try SKLite.step(stmt)
        XCTAssertEqual(SKLite.dataCount(stmt: stmt), 1)
        try SKLite.finalize(stmt)
        try SKLite.close(conn)
    }
}
