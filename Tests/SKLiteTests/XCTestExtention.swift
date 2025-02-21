import XCTest

extension XCTestCase {
    static let tmpDir = "SKLiteTestFiles(You can delete it safely)"
    
    func randomDbName() -> String {
        return "SKLiteTest_\(UUID().uuidString).db"
    }
    
    func randomDbNameWithDirectory() -> String {
        return "\(Self.tmpDir)/\(randomDbName())"
    }
}
