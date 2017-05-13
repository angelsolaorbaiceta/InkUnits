import Foundation

public enum UnitConversionError: Error, CustomStringConvertible
{
	case inconsistentUnits(sourceUnits: String, targetUnits: String)
	
	public var description: String
	{
		switch self
		{
			case let .inconsistentUnits(sourceUnits, targetUnits):
				return "Cannot convert from \(sourceUnits) to \(targetUnits)"
		}
	}
}
