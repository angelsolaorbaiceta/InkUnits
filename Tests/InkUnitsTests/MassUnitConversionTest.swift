import XCTest
import InkUnits

class MassUnitConversionTest: UnitConversionBaseTest
{
	// MARK:- International System
	func testConvertFromGramsToGrams()
	{
		XCTAssertEqual(
			try! converter!.convert(25, from: "g", to: "g"),
			25
		)
	}
	
	func testConvertFromGramsToMilligrams()
	{
		XCTAssertEqual(
			try! converter!.convert(25, from: "g", to: "mg"),
			25000
		)
	}
	
	func testConvertFromCentigramsToMilligrams()
	{
		XCTAssertEqual(
			try! converter!.convert(13, from: "cg", to: "mg"),
			130
		)
	}
	
	func testConvertFromHectogramsToGrams()
	{
		XCTAssertEqual(
			try! converter!.convert(85, from: "hg", to: "g"),
			8500
		)
	}
	
	// MARK:- U.S. System
	func testConvertFromOunzesToPounds()
	{
		XCTAssertEqual(
			try! converter!.convert(10, from: "oz", to: "lb"),
			0.625
		)
	}
	
	// MARK:- Inter-System Conversion
	func testConvertFromOunzesToMilligrams()
	{
		XCTAssertEqual(
			try! converter!.convert(1000, from: "oz", to: "mg"),
			28349523.125
		)
	}
}
