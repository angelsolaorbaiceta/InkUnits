# Configuration
- [Introduction](#introduction)
- [Configuration File Structure](#configuration-file-structure)
- [Same System Conversion Factors](#same-system-conversion-factors)
- [Conversion Factors Between Systems](#conversion-factors-between-systems)
- [Conversion Algorithm](#conversion-algorithm)

## Introduction
The units supported by _InkUnits_ can be checked in the [configuration file](../Configuration/UnitConversions.plist). This configuration file is formatted as a **plist**. You can read about _plist_ files [here](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/AboutInformationPropertyListFiles.html#//apple_ref/doc/uid/TP40009254-SW1).

Units are arranged in [groups](Terminology.md/#unit-group) based on the magnitude they measure (length, mass...). Each group may define [conversion factors](Terminology.md/#conversion-factor) for one or more unit systems. There are three unit systems used at the moment:

- **Universal**: Used when a magnitude is represented using the same units worldwide (e.g. angles in radians or time in seconds).
- **International**: [International System of Units](https://en.wikipedia.org/wiki/International_System_of_Units).
- **US**: [Imperial / US Customary System of Units](https://en.wikipedia.org/wiki/Imperial_and_US_customary_measurement_systems).

For each of the supported unit systems in a group, conversion factors between units are provided in a dictionary-like way (key: value). Also, conversion factors between different units systems need to be provided. This is explain in detail in the next sections.

## Configuration File Structure
`UnitConversions.plist` file has the following external structure:

```xml
<dict>
    <key>Unit Group Name</key>
    <dict>
        <!-- Unit group data -->
    </dict>

    <key>Unit Group Name</key>
    <dict>
        <!-- Unit group data -->
    </dict>
</dict>
```

As you can see, the configuration file is a dictionary of names of unit groups as keys, with a dictionary of data as value. Each of the **unit groups** has the following structure:

```xml
<key>Unit Group Name</key>
<dict>
    <!-- [1] SAME SYSTEM CONVERSION FACTORS -->
    <key>systems</key>
    <array>
        <dict>
            <key>name</key>
            <string>unit system name</string>

            <key>factors</key>
            <dict>
                <key>unit name</key>
                <real>1.0</real>
                <!-- other factors here ... --->
            </dict>
        </dict>
        <!-- other unit systems here ... -->
    </array>

    <!-- [2] CONVERSION FACTORS BETWEEN SYSTEMS -->
    <!-- factors to convert units between the systems defined above -->
    <!-- only necessary if there is more than one system of units -->
    <key>system_conversion_factors</key>
    <array>
        <dict>
            <key>from</key>
            <string>unit system name ONE</string>

            <key>to</key>
            <string>unit system name TWO</string>

            <key>factor</key>
            <real>1.0</real>
        </dict>
        <dict>
            <key>from</key>
            <string>unit system name TWO</string>

            <key>to</key>
            <string>unit system name ONE</string>

            <key>factor</key>
            <real>1.0</real>
        </dict>
    </array>
</dict>
```

The configuration of one unit group has two parts:
1. An array of supported unit systems (_universal_, _international_, _us_). This part is called the **same system conversion factors**.
2. An array of conversion factors between systems defined in 1. This section is called the **conversion factors between systems**.

These two parts are described in the two sections below. Let's see a simplified **example** of a unit group with two unit systems:

```xml
<key>length</key>
<dict>
    <!-- [1] SAME SYSTEM CONVERSION FACTORS -->
    <key>systems</key>
    <array>
        <!-- International System -->
        <dict>
            <key>name</key>
            <string>international</string>
            <key>factors</key>
            <dict>
                <key>cm</key><real>0.01</real>
                <key>dm</key><real>0.1</real>
                <key>m</key><real>1</real>
            </dict>
        </dict>

        <!-- US System -->
        <dict>
            <key>name</key>
            <string>us</string>
            <key>factors</key>
            <dict>
                <key>mi</key><real>5280</real>
                <key>ft</key><real>1</real>
                <key>in</key><real>0.08333</real>
            </dict>
        </dict>
    </array>

    <!-- [2] CONVERSION FACTORS BETWEEN SYSTEMS -->
    <key>system_conversion_factors</key>
    <array>
        <dict>
            <key>from</key><string>international</string>
            <key>to</key><string>us</string>
            <key>factor</key><real>3.2808</real>
        </dict>
        <dict>
            <key>from</key><string>us</string>
            <key>to</key><string>international</string>
            <key>factor</key><real>0.3048</real>
        </dict>
    </array>
</dict>
```

## Same System Conversion Factors
These are the conversion factors to convert between untis belonging to the same [unit system](Terminology.md/#unit-system). For instance, in the example above there are three factors defined, namely:

- **cm** = 0.01
- **dm** = 0.1
- **m** = 1

It is important to note that, there must always be a factor of 1 for every unit system. The unit with a factor of one is the [base unit](Terminology.md/#base-unit). In the case of _length_ in the _International System_, meters have been chosen to be the base units, but this is arbitrary. The fators of other units represent the **number that the magnitude to be converted needs to be multiplied by to be in base units**. Thus, if we have centimeters and want to convert to meters, we have to multiply the amount by 0.01, which is the factor in the configuration. If we wanted the opposite conversion (from meters to centimeters), we would need to multiply the amount by the opposite factor listed in centimeters, or, what is the same, divide the amount by the factor in centimeters (`1 / 0.01 = 100`).

So, remember:
- convert from **X** to **base** -> multiply by factor listed in **X**
- convert from **base** to **X** -> divide by factor listend in **base**

**What happens when we want to convert from two non-base units?**
Say we want to convert from centimeters to decimeters. The way we compute the factor is by computing two separate factors and merging them into one as follows:
1. Compute factor from **X** to **base**
2. Compute factor from **base** to **Y**
3. Multiply factors computed in _(1)_ and _(2)_

## Conversion Factors Between Systems
One more piece of data is necessary for conversions to happen: a factor to convert units in different systems. _InkUnits_ defines factors to convert between **base units** in the different systems of a unit group.

We need as many of these factors as [permutations without repetition](https://www.mathsisfun.com/combinatorics/combinations-permutations.html) we have between the unit systems of a group. Permutation means that order matters, because, it is not the same factor we need to convert from _system A_ base units to _system B_ base units than the one for the opposite conversion (from _system A_ to _system B_).

For example, say we have the unit group of **length**, which has defined two unit systems: **International** and **US**. We need a total of `n! / (n - r)!` conversion factors, where `n` is the number of unit systems and `r` is two (we combine them two by two). This yields a total of two factors, namely:

1. from **International** base units to **US** base units (_cm_ -> _ft_)
2. from **US** base units to **International** base units (_ft_ -> _cm_)

## Conversion Algorithm
Now that we have an understanding of how we use factors to convert between units in the same unit system and factors to convert between base units on different systems, let's take a look to the complete algorithm used to compute **conversion factors between non-base units on different unit systems**, that is, the most generic case.

Say we have two [unit systems](Terminology.md/#unit-system) inside a same [unit group](Terminology.md/#unit-group). Let's call them:
- System A
- System B

We want to convert from **Ax**, unit from _System A_ to **Bx**, unit from _System B_. In order to keep the example as generic as possible, let's assume neither **Ax** nor **Bx** are [base units](Terminology.md/#base-unit).

The steps to compute the conversion factor from **Ax** to **Bx** are as follow:
1. Compute **fa**: factor to convert **Ax** to base units in _System A_
2. Compute **fab**: factor to convert from base units in _System A_ to base units in _System B_
3. Compute **fb**: factor to convert from base units in _System B_ to **Bx**
4. The factor: `f = fa * fab * fb`
