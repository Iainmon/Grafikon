import XCTest
@testable import DrawKit

final class DrawKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DrawKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
