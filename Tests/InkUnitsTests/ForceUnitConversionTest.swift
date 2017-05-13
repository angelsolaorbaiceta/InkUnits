import XCTest

class ForceUnitConversionTest: UnitConversionBaseTest
{
	// MARK:- International System
	func testConvertFromNewtonsToKiloNewtons()
	{
		XCTAssertEqual(
			try! converter!.convert(2500, from: "N", to: "kN"),
			2.5
		)
	}
	
	// MARK:- Inter-System Conversion
	func testConvertNewtonsToPoundsForce()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(1000, from: "N", to: "lbf"),
			224.808943871,
			accuracy: conversionAccuracy
		)
	}
	
	func testConvertPoundsForceToNewtons()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(1000, from: "lbf", to: "N"),
			4448.2216,
			accuracy: conversionAccuracy
		)
	}
}
