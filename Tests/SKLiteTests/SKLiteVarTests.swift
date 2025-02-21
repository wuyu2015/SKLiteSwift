import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteVarTests: XCTestCase {
    
    func testPrint_documentDirectoryURL() {
        pr(SKLite.documentDirectoryURL)
    }
    
    func testPrint_homeDirectoryURL() {
        pr(SKLite.homeDirectoryURL)
    }
    
    func testPrint_downloadsDirectoryURL() {
        pr(SKLite.downloadsDirectoryURL)
    }

    func testPrint_version() {
        pr(SKLite.version)
    }
    
    func testPrint_versionNumber() {
        pr(SKLite.versionNumber)
    }
    
    func testPrint_sourceId() {
        pr(SKLite.sourceId)
    }
    
    func testPrint_tempDirectory() {
        pr(SKLite.tempDirectory ?? "nil")
    }
    
    func testPrint_dataDirectory() {
        pr(SKLite.dataDirectory ?? "nil")
    }
    
    func testPrint_vfsName() {
        pr(SKLite.vfsName ?? "nil")
    }
    
    func testPrint_threadSafe() {
        pr(SKLite.threadSafe)
    }
    
    func testPrint_isThreadSafe() {
        pr(SKLite.isThreadSafe)
    }
    
    func testPrint_isSingleThreaded() {
        pr(SKLite.isSingleThreaded)
    }
    
    func testPrint_isMultiThreaded() {
        pr(SKLite.isMultiThreaded)
    }
}
