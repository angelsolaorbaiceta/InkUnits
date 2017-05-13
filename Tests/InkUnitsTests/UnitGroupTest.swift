import XCTest
@testable import InkUnits

class UnitGroupTest: XCTestCase
{
	var group: UnitGroup?
	
	override func setUp()
	{
		let path = Bundle(for: UnitGroupTest.self).path(forResource: "TestUnitGroupConversions", ofType: "plist")!
		let config = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
		
		group = UnitGroup.makeFromDict(name: "test",
		                               data: config)
	}
	
    func testCanCreateFromJSONWithUnitNames()
	{
		XCTAssertTrue(group!.hasUnitNamed("a"))
		XCTAssertTrue(group!.hasUnitNamed("b"))
		XCTAssertTrue(group!.hasUnitNamed("c"))
		XCTAssertTrue(group!.hasUnitNamed("d"))
	}
	
	func testCanComputeConversionFactor()
	{
		XCTAssertEqual(
			group!.conversionFactor(from: "b", to: "c"),
			0.1
		)
	}
	
	func testCannotComputeFactor()
	{
		XCTAssertFalse(
			group!.canComputeFactor(from: "a", to: "j")
		)
	}
	
	func testCanComputeFactor()
	{
		XCTAssertTrue(
			group!.canComputeFactor(from: "a", to: "d")
		)
	}
}
