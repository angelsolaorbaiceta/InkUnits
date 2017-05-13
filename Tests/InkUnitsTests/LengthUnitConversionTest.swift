import XCTest
import InkUnits

class LengthUnitConversionTest: UnitConversionBaseTest
{
	// MARK:- International System
	func testConvertFromCentimetersToMeters()
	{
		XCTAssertEqual(
			try! converter!.convert(250, from: "cm", to: "m"),
			2.5
		)
    }
	
	func testConvertFromMetersToCentimeters()
	{
		XCTAssertEqual(
			try! converter!.convert(2.5, from: "m", to: "cm"),
			250
		)
	}
	
	func testConvertFromMillimetersToCentimeters()
	{
		XCTAssertEqual(
			try! converter!.convert(250, from: "mm", to: "cm"),
			25
		)
	}
	
	func testConvertFromMillimetersToMeters()
	{
		XCTAssertEqual(
			try! converter!.convert(3450, from: "mm", to: "m"),
			3.45
		)
	}
	
	func testConvertFromDecimetersToDecimeters()
	{
		XCTAssertEqual(
			try! converter!.convert(167, from: "dm", to: "dm"),
			167
		)
	}
	
	func testConvertFromHectometersToMillimeters()
	{
		XCTAssertEqual(
			try! converter!.convert(2, from: "hm", to: "mm"),
			200000
		)
	}
	
	func testConvertFromKilometersToDecameters()
	{
		XCTAssertEqual(
			try! converter!.convert(97, from: "km", to: "dam"),
			9700
		)
	}
	
	func testConvertFromMetersToKilometers()
	{
		XCTAssertEqual(
			try! converter!.convert(34, from: "m", to: "km"),
			0.034
		)
	}
	
	// MARK:- U.S. System
	func testConvertFromMilesToFeet()
	{
		XCTAssertEqual(
			try! converter!.convert(1, from: "mi", to: "ft"),
			5280
		)
	}
	
	// MARK:- Inter-System Conversion
	func testConvertFromFeetToMeters()
	{
		XCTAssertEqual(
			try! converter!.convert(10, from: "ft", to: "m"),
			3.048
		)
	}
	
	func testConvertFromCentimetersToMiles()
	{
		XCTAssertEqual(
			try! converter!.convert(10, from: "cm", to: "mi"),
			3.2808/52800
		)
	}
}
