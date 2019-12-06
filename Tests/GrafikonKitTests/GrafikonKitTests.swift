import XCTest
@testable import GrafikonKit

final class DrawKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GrafikonKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
