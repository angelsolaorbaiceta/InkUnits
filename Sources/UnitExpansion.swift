import Foundation

struct UnitExpansion: Equatable
{
	let numerator: [String]
	let denominator: [String]
	
	init(numerator: [String], denominator: [String])
	{
		self.numerator = numerator
		self.denominator = denominator
	}
}

func == (lhs: UnitExpansion, rhs: UnitExpansion) -> Bool
{
	return lhs.numerator.elementsEqual(rhs.numerator) && lhs.denominator.elementsEqual(rhs.denominator)
}
