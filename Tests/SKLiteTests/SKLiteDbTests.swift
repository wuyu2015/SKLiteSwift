import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteDbTests: XCTestCase {
    
    func testInit1() throws {
        _ = try SKLite.Db()
    }
    
    func testInit2() throws {
        let dbName = randomDbName()
        let db = try SKLite.Db(pathInDocumentDirectory: dbName, flags: [.READWRITE, .CREATE])
        try db.close()
        try SKLite.removeInDocumentDirectory(dbName)
    }
    
    func testInit3() throws {
        let dbName = randomDbName()
        let db = try SKLite.Db(pathInHomeDirectory: dbName, flags: [.READWRITE, .CREATE])
        try db.close()
        try SKLite.removeInHomeDirectory(dbName)
    }
    
    func testInit4() throws {
        let dbName = randomDbName()
        let db = try SKLite.Db(pathInDownloadsDirectory: dbName, flags: [.READWRITE, .CREATE])
        try db.close()
        try SKLite.removeInDownloadsDirectory(dbName)
    }
    
    func testInit5() throws {
        let dbName = randomDbNameWithDirectory()
        let db = try SKLite.Db(pathInDownloadsDirectory: dbName, flags: [.READWRITE, .CREATE])
        try db.close()
        try SKLite.removeInDownloadsDirectory(dbName)
    }
    
    func testClose() throws {
        let db = try SKLite.Db()
        try db.close()
    }
    
    func testExec() throws {
        let db = try SKLite.Db()
        try db.exec("select 1 + 1")
    }
    
    func testFileName1() throws {
        let db = try SKLite.Db()
        if let filePath = db.fileName() {
            pr(filePath)
        }
    }
    
    func testFileName2() throws {
        let dbName = randomDbName()
        let db = try SKLite.Db(pathInDocumentDirectory: dbName, flags: [.READWRITE, .CREATE])
        if let filePath = db.fileName() {
            pr(filePath)
        }
        try db.close()
        try SKLite.removeInDocumentDirectory(dbName)
    }
    
    func testPrepare() throws {
        let db = try SKLite.Db()
        let stmt = try db.prepare(sql: "select 1 + 1")
        try stmt.step()
    }
    
    func testReadable() throws {
        let db = try SKLite.Db()
        XCTAssertTrue(db.readable())
    }
    
    func testReadOnly() throws {
        let db = try SKLite.Db()
        XCTAssertFalse(db.readOnly())
    }
    
    func testWritable() throws {
        let db = try SKLite.Db()
        XCTAssertTrue(db.writable())
    }
}
