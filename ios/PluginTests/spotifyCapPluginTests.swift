import XCTest
@testable import Plugin

class spotifyCapPluginTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEcho() {
        // This is an example of a functional test case for a plugin.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let implementation = spotifyCapPlugin()
        let value = "Hello, World!"
        let result = implementation.echo(value)

        XCTAssertEqual(value, result)
    }
    
    func testInstalled() {
        let implementation = spotifyCapPlugin()
        let value = true
        let result = implementation.isInstalled()
        print("Spotify installed \(value)")

        XCTAssertEqual(value, result)
    }
}
