# Terminology
This page contains the definition of the concepts used throghout the documentation and code alike.

- [Unit Group](#unit-group)
- [Unit System](#unit-system)
- [Base Unit](#base-unit)
- [Non Base Unit](#non-base-unit)
- [Conversion Factor](#conversion-factor)

### Unit Group
Set of related units used to express magnitudes of the **same physical quantity**. Examples of unit groups are:
- length
- mass
- time
- force
- ...

### Unit System
Standarized set of units used in a particular geographical region. _InkUnits_ deals with two main unit systems: **International** and **US / Imperial**. **Universal** is used as a unit system for those units that are used worldwide. E.g. _seconds_ for time or _radians_ for angles. It is a convention for _InkStructure_ as there is no such standarized unit system.

### Base Unit
A Base Unit inside a [Unit System](#unit-system) is the unit that is taken as reference, thus having a conversion factor of 1.

### Non Base Unit
All units in a [Unit System](#unit-system) other than [Base Units](#base-units). Therefore, non-base units never have a conversion factor of 1.

### Conversion Factor
Number used to convert a magnitude from one particular unit to other.
