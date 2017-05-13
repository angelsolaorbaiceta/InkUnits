import XCTest
import InkUnits

class AngleUnitConversionTest: UnitConversionBaseTest
{
    func testConvertFromRadiansToDegrees()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(Double.pi, from: "rad", to: "deg"),
			180.0,
			accuracy: 1e-7
		)
	}
	
	func testConvertFromDegreesToRadians()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(360, from: "deg", to: "rad"),
			Double.pi * 2,
			accuracy: 1e-7
		)
	}
}
