![Alt InkUnits](Documentation/Images/InkUnits.png)

# InkUnits
Smart and lightweight unit conversion module written in Swift. _InkUnits_ is responsible for all unit conversions behind [InkStructure](http://www.inkstructure.com) OSX app.

- [Basic Usage](#basic-usage)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
- [Currently Supported Units](#currently-supported-units)

# Basic Usage
Instantiate `UnitConversionEngine`:
```swift
let converter = UnitConversionEngine()
```

Then use the engine to make conversions:
```swift
try! converter.convert(25, from: "kg/m2", to: "g/cm2")
```
Yields:
> 2.5

You can make sure a given conversion can happen before attempting it:
```swift
if converter.canConvert(from: "N·cm", to: "kN·m")
{
    try! converter.convert(100, from: "N·cm", to: "kN·m")
}
```
Yields:
> 0.001

Alternatively, you can work with exceptions:
```swift
do
{
    try converter.convert(100, from: "N·cm", to: "kg/m")
}
catch UnitConversionError.inconsistentUnits(let sourceUnits, let targetUnits)
{
    print("Oops! couldn't convert from \(sourceUnits) to \(targetUnits)")
}
```
Prints:
> "Oops! couldn't convert from N·cm to kg/m"

Or this other way:
```swift
do
{
    try converter.convert(100, from: "N·cm", to: "kg/m")
}
catch let error as UnitConversionError
{
    print(error.description)
}
```
Prints:
> "Cannot convert from N·cm to kg/m"

See more in the [documentation](Documentation/Usage.md).

# Installation
You can add _InkUnits_ to your projects in one of the following ways:

## Swift Package Manager
Add the following dependency in your `Package.swift` file:
```swift
dependencies: [
    .Package(url: "https://github.com/angelsolaorbaiceta/InkUnits.git", majorVersion: 1)
]
```

## CocoaPods
TODO: add CocoaPods support.

## Carthage
TODO: add Carthage support.

# Currently Supported Units
For more details about how the configuration of _InkUnits_ works and how to add more conversion factors, refer to [Configuration](Documentation/Configuration.md).

Units that are currently present in the configuration are collected in the following table.

| Magnitude  | Universal Units  | International Units          | US / Imperial Units   |
| ---------: | :--------------: | :--------------------------: | :-------------------: |
| Time       | ms, s, min, h, day, week, month, year | -       | -                     |
| Angle      | rad, deg         | -                            | -                     |
| Length     | -                | mm, cm, dm, m, dam, hm, km   | mi, ft, in            |
| Mass       | -                | mg, cg, dg, g, dag, hg, kg   | oz, lb                |
| Force      | -                | N, kN, MN                    | lbf                   |

Note that, any compound unit using these simple ones will also be able to be converted by _InkUnits_, and there is where its power lies. For example, the following are understood by the conversion engine:

- **Area**: _cm2_, _m2_, _ft2_...
- **Density**: _g/cm3_, _kg/m3_, _oz/ft3_...
- **Moment**: _N·m_, _lbf·ft_...

To add more unit conversion factors, see instructions in [Configuration Documentation page](Documentation/Configuration.md).
