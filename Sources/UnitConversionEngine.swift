import Foundation

public class UnitConversionEngine
{
	// MARK: Data
	private let expander: UnitExpander
	private let unitGroups: [UnitGroup]
	
	// MARK: Initialization
	public init()
	{
		let configPath = Bundle(for: UnitConversionEngine.self).path(forResource: "UnitConversions", ofType: "plist")!
		let unitGroupsDict = NSDictionary(contentsOfFile: configPath) as! [String: AnyObject]
		var unitGroups = [UnitGroup]()
		
		for unitGroupName in unitGroupsDict.keys
		{
			unitGroups.append(
				UnitGroup.makeFromDict(name: unitGroupName, data: unitGroupsDict[unitGroupName] as! [String: AnyObject])
			)
		}
		
		self.expander = UnitExpander()
		self.unitGroups = unitGroups
	}
	
	// MARK: Convert
	public func convert(_ amount: Double, from sourceUnits: String, to targetUnits: String) throws -> Double
	{
		let sourceUnitsExpansion = expander.expand(sourceUnits)
		let targetUnitsExpansion = expander.expand(targetUnits)
		
		guard areUnitsConsistent(sourceUnitsExpansion, targetUnitsExpansion) else
		{
			throw UnitConversionError.inconsistentUnits(sourceUnits: sourceUnits, targetUnits: targetUnits)
		}
		
		return amount * compoundConversionFactor(from: sourceUnitsExpansion, to: targetUnitsExpansion)
	}
	
	public func canConvert(from sourceUnits: String, to targetUnits: String) -> Bool
	{
		return areUnitsConsistent(expander.expand(sourceUnits),
		                          expander.expand(targetUnits))
	}
	
	private func areUnitsConsistent(_ sourceUnits: UnitExpansion, _ targetUnits: UnitExpansion) -> Bool
	{
		let sourceNumeratorUnits = sourceUnits.numerator.map { return groupName(forUnitNamed: $0) }
		let sourceDenominatorUnits = sourceUnits.denominator.map { return groupName(forUnitNamed: $0) }
		let targetNumeratorUnits = targetUnits.numerator.map { return groupName(forUnitNamed: $0) }
		let targetDenominatorUnits = targetUnits.denominator.map { return groupName(forUnitNamed: $0) }
		
		return sourceNumeratorUnits.elementsEqual(targetNumeratorUnits) &&
			   sourceDenominatorUnits.elementsEqual(targetDenominatorUnits)
	}
	
	private func groupName(forUnitNamed unitName: String) -> String
	{
		return unitGroup(forUnitNamed: unitName).name
	}
	
	private func compoundConversionFactor(from sourceUnits: UnitExpansion, to targetUnits: UnitExpansion) -> Double
	{
		let numeratorFactor = reduceConversionFactor(sourceUnits.numerator, targetUnits.numerator)
		let denominatorFactor = reduceConversionFactor(sourceUnits.denominator, targetUnits.denominator)
		
		return numeratorFactor / denominatorFactor
	}
	
	private func reduceConversionFactor(_ sourceUnits: [String], _ targetUnits: [String]) -> Double
	{
		return zip(
			sourceUnits,
			targetUnits
		)
		.reduce(
			1,
			{ (result, unitsTuple) -> Double in
				result * simpleConversionFactor(from: unitsTuple.0, to: unitsTuple.1)
			}
		)
	}
	
	private func simpleConversionFactor(from sourceUnits: String, to targetUnits: String) -> Double
	{
		return unitGroup(forUnitNamed: sourceUnits).conversionFactor(from: sourceUnits, to: targetUnits)
	}
	
	private func unitGroup(forUnitNamed name: String) -> UnitGroup
	{
		// TODO: Add cache here
		return unitGroups.first(where: { $0.hasUnitNamed(name) })!
	}
}
