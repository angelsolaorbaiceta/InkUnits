# Usage

- [Conversion Engine](#conversion-engine)
- [Valid Units Format](#valid-units-format)
- [Handling Failure](#handling-failure)
    - [Can Convert Pattern](#can-convert-pattern)
    - [Try Catch Pattern](#try-catch-pattern)

## Conversion Engine
_InkUnits_ has one main entry point, which is the class `UnitConversionEngine`. This class, when instantiated, parses the configuration file (`UnitConversions.plist`) containing all conversion factors, and provides two public methods: `canConvert from:to:` and `convert:from:to`.

The first method checks if a given conversion can be made before attempting it:

```swift
func canConvert(from sourceUnits: String, to targetUnits: String) -> Bool
```

The other method, actually makes the conversion:

```swift
func convert(_ amount: Double, from sourceUnits: String, to targetUnits: String) throws -> Double
```

As instantiating a `UnitConversionEngine` parses the configuration file, it is an "expensive" operation, thus it is recommended that you only create one instance of this class for your application. `UnitConversionEngine` is not provided as a singleton, so it's your responsibility to make sure only one is created.

`UnitConversionEngine` has one parameterless constructor. You instantiate it as follows:
```swift
let converter = UnitConversionEngine()
```

## Valid Units Format
Source and target units are expressed as strings. The units can be simple (e.g. _cm_) or compound (e.g. _kg/cm2_). Units follow the following formatting rules:

- Units may have a _numerator_ and _denominator_, which are separated by a "/" character. For Example:
    - _kg/cm2_
    - _mi/h_
- Compund units with simple units multiplying each other are separated by a "·" character. For Example:
    - _N·m_
    - _lb·m/s_

## Handling Failure
Sometimes, magnitudes cannot be converted from some source units to other target units. When this is the case, we say that source and target units **are inconsistent**.

For example, you cannot convert from _mi/h_ to _kg/cm3_, it simply makes no sense.

This cases may be handled using two different patters:

### Can Convert Pattern
If you prefer to check whether a certain conversion could happen before attempting it (as opposed to attempting it and handling possible errors), use the following pattern:
```swift
if converter.canConvert(from: "N·cm", to: "kN·m")
{
    // safe to force try: exceptions won't happen here
    try! converter.convert(100, from: "N·cm", to: "kN·m")
}
else
{
    // handle inability to convert here
}
```

### Try Catch Pattern
If you feel more confortable with handling exceptions, do the following:
```swift
do
{
    try converter.convert(100, from: "N·cm", to: "kg/m")
}
catch UnitConversionError.inconsistentUnits(let sourceUnits, let targetUnits)
{
    // Attempt to recover from conversion exception here
    print("Oops! I can't convert from \(sourceUnits) to \(targetUnits)")
}
```

Or:
```swift
do
{
    try converter.convert(100, from: "N·cm", to: "kg/m")
}
catch let error as UnitConversionError
{
    // Attempt to recover from conversion exception here
    print(error.description)
}
```
