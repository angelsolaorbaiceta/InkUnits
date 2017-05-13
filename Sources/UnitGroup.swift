import Foundation

class UnitGroup
{
	typealias UnitName = String
	typealias UnitSystem = String
	typealias UnitFactor = Double
	
	// MARK:- Data
	private let unitConversionFactors: [UnitName: UnitSystemFactor]
	private let systemConversionFactors: [UnitSystem: [UnitSystem: UnitFactor]]
	
	// MARK:- Properties
	public let name: String
	
	// MARK:- Creation
	private init(name: String,
	             unitConversionFactors: [UnitName: UnitSystemFactor],
	             systemConversionFactors: [UnitSystem: [UnitSystem: UnitFactor]])
	{
		self.name = name
		self.unitConversionFactors = unitConversionFactors
		self.systemConversionFactors = systemConversionFactors
	}
	
	static func makeFromDict(name: String, data: [String: AnyObject]) -> UnitGroup
	{
		return UnitGroup(name: name,
		                 unitConversionFactors: parseUnitConversionFactors(fromDict: data),
		                 systemConversionFactors: parseSystemConversionFactors(fromDict: data))
	}
	
	private static func parseUnitConversionFactors(fromDict data: [String: AnyObject]) -> [UnitName: UnitSystemFactor]
	{
		let unitSystemsArray = data["systems"] as! [AnyObject]
		var units = [UnitName: UnitSystemFactor]()
		
		for unitSystem in unitSystemsArray
		{
			let systemName = unitSystem["name"] as! String
			let factors = unitSystem["factors"] as! [String: AnyObject]
			
			for factorName in factors.keys
			{
				units[factorName] = UnitSystemFactor(system: systemName,
				                                     factor: factors[factorName] as! Double)
			}
		}
		
		return units
	}
	
	private static func parseSystemConversionFactors(fromDict data: [String: AnyObject]) -> [UnitSystem: [UnitSystem: UnitFactor]]
	{
		var systemConversionFactors = [UnitSystem: [UnitSystem: UnitFactor]]()
		let hasMoreThanOneUnitSystem = (data["systems"] as! [AnyObject]).count > 1
		
		if hasMoreThanOneUnitSystem
		{
			let systemConversionFactorsArray = data["system_conversion_factors"] as! [AnyObject]
			
			for systemConversionFactor in systemConversionFactorsArray
			{
				let from = systemConversionFactor["from"] as! String
				let to = systemConversionFactor["to"] as! String
				let factor = systemConversionFactor["factor"] as! Double
				
				systemConversionFactors[from] = [to: factor]
			}
		}
		
		return systemConversionFactors
	}
	
	// MARK:- Methods
	func hasUnitNamed(_ name: String) -> Bool
	{
		return unitConversionFactors[name] != nil
	}
	
	func canComputeFactor(from sourceUnits: String, to targetUnits: String) -> Bool
	{
		return hasUnitNamed(sourceUnits) && hasUnitNamed(targetUnits)
	}
	
	func conversionFactor(from sourceUnits: String, to targetUnits: String) -> Double
	{
		// TODO: add cache here
		let sourceUnitSystem = unitConversionFactors[sourceUnits]!.system
		let targetUnitSystem = unitConversionFactors[targetUnits]!.system
		
		
		if sourceUnitSystem == targetUnitSystem
		{
			return conversionFactorToBaseUnits(from: sourceUnits) *
				conversionFactorFromBaseUnits(to: targetUnits)
		}
		else
		{
			return conversionFactorToBaseUnits(from: sourceUnits) *
				systemConversionFactors[sourceUnitSystem]![targetUnitSystem]! *
				conversionFactorFromBaseUnits(to: targetUnits)
		}
	}
	
	private func conversionFactorToBaseUnits(from sourceUnits: String) -> Double
	{
		return unitConversionFactors[sourceUnits]!.factor
	}
	
	private func conversionFactorFromBaseUnits(to targetUnits: String) -> Double
	{
		return 1 / unitConversionFactors[targetUnits]!.factor
	}
	
	// MARK:- UnitSystemFactor
	private struct UnitSystemFactor
	{
		let system: UnitSystem
		let factor: UnitFactor
		
		init(system: UnitSystem, factor: UnitFactor)
		{
			self.system = system
			self.factor = factor
		}
	}
}
