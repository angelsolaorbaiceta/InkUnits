import XCTest
import InkUnits

class CompoundUnitConversionTest: UnitConversionBaseTest
{
	func testConvertFromSquareMillimetersToSquareMillimeters()
	{
		XCTAssertEqual(
			try! converter!.convert(25, from: "mm2", to: "mm2"),
			25
		)
	}
	
	func testConvertFromSquareCentimetersToSquareMeters()
	{
		XCTAssertEqual(
			try! converter!.convert(25, from: "cm2", to: "m2"),
			0.0025
		)
	}
	
	func testConvertFromKilogramsPerSquareMeterToGramsPerSquareCentimeter()
	{
		XCTAssertEqual(
			try! converter!.convert(25, from: "kg/m2", to: "g/cm2"),
			2.5
		)
	}
}
