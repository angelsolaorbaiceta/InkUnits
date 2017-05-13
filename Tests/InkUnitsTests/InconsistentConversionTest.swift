import XCTest
import InkUnits

class InconsistentConversionTest: UnitConversionBaseTest
{
	func testCanDetermineConversionCannotHappen()
	{
		XCTAssertFalse(
			converter!.canConvert(from: "kg/cm2", to: "m/ft3")
		)
	}
	
	func testCanDetermineConversionCanHappen()
	{
		XCTAssertTrue(
			converter!.canConvert(from: "kg/cm2", to: "g/mm2")
		)
	}
	
	func testCannotConvertFromMassToLengthUnits()
	{
		XCTAssertThrowsError(
			try converter!.convert(45, from: "kg", to: "m")
		)
	}
	
	func testCannotConvertFromGramsMeterToSquareCentimeters()
	{
		XCTAssertThrowsError(
			try converter!.convert(45, from: "g/m", to: "cm2")
		)
	}
}
