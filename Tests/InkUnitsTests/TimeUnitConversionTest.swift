import XCTest
import InkUnits

class TimeUnitConversionTest: UnitConversionBaseTest
{
    func testCanConvertFromSecondsToMinutes()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(120, from: "s", to: "min"),
			2.0,
			accuracy: conversionAccuracy
		)
	}
	
	func testCanConvertFromMinutesToHours()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(90, from: "min", to: "h"),
			1.5,
			accuracy: conversionAccuracy
		)
	}
	
	func testCanConvertFromHoursToDays()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(48, from: "h", to: "day"),
			2.0,
			accuracy: conversionAccuracy
		)
	}
	
	func testCanConvertFromDaysToWeeks()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(21, from: "day", to: "week"),
			3.0,
			accuracy: conversionAccuracy
		)
	}
	
	func testCanConvertFromDaysToMonths()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(45, from: "day", to: "month"),
			1.5,
			accuracy: conversionAccuracy
		)
	}
	
	func testCanConvertFromDaysToYears()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(365.2425, from: "day", to: "year"),
			1.0,
			accuracy: conversionAccuracy
		)
	}
	
	func testCanConvertFromMilliSecondsToSeconds()
	{
		XCTAssertEqualWithAccuracy(
			try! converter!.convert(3500, from: "ms", to: "s"),
			3.5,
			accuracy: conversionAccuracy
		)
	}
}
