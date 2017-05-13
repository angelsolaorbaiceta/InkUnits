![Alt InkUnits](Documentation/Images/InkUnits.png)

# InkUnits
Smart and lightweight unit conversion module written in Swift. _InkUnits_ is the responsible of all unit conversions behind [InkStructure](www.inkstructure.com) OSX app.

# Basic Usage
First, instantiate `UnitConversionEngine`:
```swift
let converter = UnitConversionEngine()
```

Then use the engine to make conversions:
```swift
try! converter.convert(25, from: "kg/m2", to: "g/cm2")
```

Yields:
> 2.5

See more in the [documentation](Documentation/Usage.md).

# Installation
You can add _InkUnits_ in several ways:

## Swift Package Manager
Add the following dependency in your `Package.swift` file:
```swift
dependencies: [
    .Package(url: "https://github.com/angelsolaorbaiceta/InkUnits.git", majorVersion: 1)
]
```
