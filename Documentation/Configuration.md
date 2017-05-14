# Configuration
The units supported by _InkUnits_ can be checked in the [configuration file](Configuration/UnitConversions.plist).

Units are arranged by groups based on the magnitude they measure (length, mass...). Each group may define conversion factors for one or more unit systems. There are three unit systems used at the moment:

- **Universal**: Used when a magnitude is represented with the same units worldwide (e.g. angles in radians).
- **International**: [International System of Units](https://en.wikipedia.org/wiki/International_System_of_Units).
- **US**: [Imperial / US Customary System of Units](https://en.wikipedia.org/wiki/Imperial_and_US_customary_measurement_systems).

For each of the supported unit systems in a group, conversion factors between 
