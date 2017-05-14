# Usage
_InkUnits_ has one main entry point, which is the class `UnitConversionEngine`. This class, when instantiated, parses the configuration file (`UnitConversions.plist`) containing all conversion factors, and provides two public methods.

The first method allows us to know if a given conversion can be made before attempting it:

```swift
func canConvert(from sourceUnits: String, to targetUnits: String) -> Bool
```

The other method, actually makes the conversion:

```swift
func convert(_ amount: Double, from sourceUnits: String, to targetUnits: String) throws -> Double
```

As instantiating a `UnitConversionEngine` parses the configuration file, it is an "expensive" operation, thus it is recommended that you only create one shared instance of this class for your application. `UnitConversionEngine` is not provided as a singleton, so it's your responsibility to make sure only one is created.
