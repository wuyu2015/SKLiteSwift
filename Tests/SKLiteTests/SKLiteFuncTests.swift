import XCTest
import XCTestDelayPrinter
@testable import SKLite

final class SKLiteFuncTests: XCTestCase {
    
    func testPrint_sleep() {
        delay {
            print("SKLite.sleep start")
            let ms = SKLite.sleep(3000)
            return "SKLite.slept \(ms) ms"
        }
    }
    
    func testPrint_getCompileOptions() {
        pr(SKLite.getCompileOptions())
    }
    
    func testPrint_memoryUsed() {
        pr(SKLite.memoryUsed())
    }
    
    func testPrint_memoryHighwater() {
        pr(SKLite.memoryHighwater(0))
    }
    
    
    func test_complete() {
        XCTAssertEqual(SKLite.complete("123"), false)
        XCTAssertEqual(SKLite.complete("123;"), false)
        XCTAssertEqual(SKLite.complete("VACUUM"), false)
        XCTAssertEqual(SKLite.complete("VACUUM;"), true)
        XCTAssertEqual(SKLite.complete("SELECT 1+1"), false)
        XCTAssertEqual(SKLite.complete("SELECT 1+1;"), true)
    }
}
