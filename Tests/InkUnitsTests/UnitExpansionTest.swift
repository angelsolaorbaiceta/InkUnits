import XCTest
@testable import InkUnits

class UnitExpansionTest: XCTestCase
{
	var expander: UnitExpander?
	
	override func setUp()
	{
		expander = UnitExpander()
	}
	
	func testExpandSimpleUnit()
	{
		let units = expander!.expand("m").numerator
		
		XCTAssertEqual(units.count, 1)
		XCTAssertTrue(units.contains("m"))
	}
	
	func testExpandSimpleUnitYieldsEmptyDenominator()
	{
		let units = expander!.expand("cm")
		
		XCTAssertTrue(units.denominator.isEmpty)
	}
	
	func testExpandSquareUnit()
	{
		let units = expander!.expand("m2").numerator
		
		XCTAssertEqual(units.count, 2)
		XCTAssertEqual(units.filter({ $0 == "m" }).count, 2)
	}
	
	func testExpandKilogramsTimesSquareMeterUnit()
	{
		let units = expander!.expand("kg·m2").numerator
		
		XCTAssertEqual(units.count, 3)
		XCTAssertEqual(units.filter({ $0 == "kg" }).count, 1)
		XCTAssertEqual(units.filter({ $0 == "m" }).count, 2)
	}
	
	func testExpandKilogramPerSquareMeterUnit()
	{
		let units = expander!.expand("kg/m2")
		let numeratorUnits = units.numerator
		let denominatorUnits = units.denominator
		
		XCTAssertEqual(numeratorUnits.count, 1)
		XCTAssertEqual(numeratorUnits.filter({ $0 == "kg" }).count, 1)
		
		XCTAssertEqual(denominatorUnits.count, 2)
		XCTAssertEqual(denominatorUnits.filter({ $0 == "m" }).count, 2)
	}
	
	// MARK:- Equality
	func testUnitExpansionsAreNotEqualIfHaveDifferentNumeratorUnits()
	{
		let expansionOne = UnitExpansion(numerator: ["cm", "kg"], denominator: ["s"])
		let expansionTwo = UnitExpansion(numerator: ["m", "hg"], denominator: ["s"])
		
		XCTAssertNotEqual(expansionOne, expansionTwo)
	}
	
	func testUnitExpansionsAreNotEqualIfHaveDifferentDenominatorUnits()
	{
		let expansionOne = UnitExpansion(numerator: ["cm", "kg"], denominator: ["s"])
		let expansionTwo = UnitExpansion(numerator: ["nm", "kg"], denominator: ["m"])
		
		XCTAssertNotEqual(expansionOne, expansionTwo)
	}
	
	func testUnitExpansionsAreEqualIfHaveSameNumeratorAndDenominatorUnits()
	{
		let expansionOne = UnitExpansion(numerator: ["cm", "kg"], denominator: ["s"])
		let expansionTwo = UnitExpansion(numerator: ["cm", "kg"], denominator: ["s"])
		
		XCTAssertEqual(expansionOne, expansionTwo)
	}
}
