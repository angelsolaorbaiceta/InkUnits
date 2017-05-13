import Foundation

internal class UnitExpander
{
	// MARK:- Data
	private let unitNameRegex = "[A-Za-z]+"
	private let unitExponentRegex = "[0-9]+"
	private let multiplierSeparator: String
	private let dividerSeparator: String
	
	// MARK:- Initialization
	internal init(multiplierSeparator: String = "·", dividerSeparator: String = "/")
	{
		self.multiplierSeparator = multiplierSeparator
		self.dividerSeparator = dividerSeparator
	}
	
	// MARK:- Methods
	internal func expand(_ units: String) -> UnitExpansion
	{
		return UnitExpansion(numerator: expandNumerator(units),
		                     denominator: expandDenominator(units))
	}
	
	private func expandNumerator(_ units: String) -> [String]
	{
		let numeratorUnits = units.components(separatedBy: dividerSeparator).first!
		return splitUnitComponents(numeratorUnits).flatMap { expandUnitTimes($0) }
	}
	
	private func expandDenominator(_ units: String) -> [String]
	{
		if hasUnitsInDenominator(units)
		{
			let denominatorUnits = units.components(separatedBy: dividerSeparator).last!
			return splitUnitComponents(denominatorUnits).flatMap { expandUnitTimes($0) }
		}
		
		return []
	}
	
	private func hasUnitsInDenominator(_ units: String) -> Bool
	{
		return units.contains(dividerSeparator)
	}
	
	private func splitUnitComponents(_ units: String) -> [String]
	{
		return units.components(separatedBy: multiplierSeparator)
	}
	
	private func expandUnitTimes(_ units: String) -> [String]
	{
		if let nameRange = units.range(of: unitNameRegex, options: .regularExpression)
		{
			return Array(
				repeating: units.substring(with: nameRange),
				count: timesUnitName(units)
			)
		}
		
		return []
	}
	
	private func timesUnitName(_ units: String) -> Int
	{
		if let exponentRange = units.range(of: unitExponentRegex, options: .regularExpression)
		{
			return Int(units.substring(with: exponentRange)) ?? 1
		}
		
		return 1
	}
}
