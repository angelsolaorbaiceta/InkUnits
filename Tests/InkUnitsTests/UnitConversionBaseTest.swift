import XCTest
import InkUnits

class UnitConversionBaseTest: XCTestCase
{
	var converter: UnitConversionEngine?
	let conversionAccuracy = 1e-7
	
	override func setUp()
	{
		converter = UnitConversionEngine()
	}
}
