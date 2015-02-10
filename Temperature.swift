//
//  tcu - Temperature Conversion Utility
//  Temperature.swift
//
//  Created by Steven Floyd on 2/9/15.
//  Copyright (c) 2015 Steven Floyd. All rights reserved.
//

import Foundation

enum TemperatureUnit: String {
    case Celcius = "°C"
    case Delisle = "°D"
    case Fahrenheit = "°F"
    case Kelvin = "K"
    case Newton = "°N"
    case Rankine = "°R"
    case Réaumur = "°Ré"
    case Rømer = "°Rø"
    
    var absoluteZero: Double {
        get {
            switch self {
            case .Celcius:
                return -273.15
            case .Delisle:
                return 559.73
            case .Fahrenheit:
                return -459.67
            case .Kelvin:
                return 0.0
            case .Newton:
                return -90.14
            case Rankine:
                return 0.0
            case Réaumur:
                return -218.52
            case .Rømer:
                return -135.90
            }
        }
    }
}

struct Temperature {
    
    private var raw: Double = 0.0
    
    var unit: TemperatureUnit = .Kelvin
    
    var celcius: Double {
        get { return self.raw - 273.15 }
        set {
            self.raw = newValue + 273.15
            self.unit = .Celcius
        }
    }
    
    var delisle: Double {
        get { return (373.15 - self.raw) * 1.5 }
        set {
            self.raw = 373.15 - newValue * (2/3)
            self.unit = .Delisle
        }
    }
    
    var fahrenheit: Double {
        get { return self.celcius * 1.8 + 32.0 }
        set {
            self.raw = (newValue - 32.0) / 1.8 + 273.15
            self.unit = .Fahrenheit
        }
    }
    
    var kelvin: Double {
        get { return self.raw }
        set {
            self.raw = newValue
            self.unit = .Kelvin
        }
    }
    
    var newton: Double {
        get { return (self.raw - 273.15) * 0.33 }
        set {
            self.raw = newValue / 0.33 + 273.15
            self.unit = .Newton
        }
    }
    
    var rankine: Double {
        get { return self.raw * 1.8 }
        set {
            self.raw = newValue * (5/9)
            self.unit = .Rankine
        }
    }
    
    var réaumur: Double {
        get { return (self.raw - 273.15) * 0.8 }
        set {
            self.raw = newValue * 1.25 + 273.15
            self.unit = .Réaumur
        }
    }
    
    var rømer: Double {
        get { return (self.raw - 273.15) * 0.525 + 7.5 }
        set {
            self.raw = (newValue - 7.5) * (40/21) + 273.15
            self.unit = .Rømer
        }
    }
    
    init(celcius value: Double) {
        self.celcius = value
        self.unit = .Celcius
    }
    
    init(delisle value: Double) {
        self.delisle = value
        self.unit = .Delisle
    }
    
    init(fahrenheit value: Double) {
        self.fahrenheit = value
        self.unit = .Fahrenheit
    }
    
    init(kelvin value: Double) {
        self.kelvin = value
        self.unit = .Kelvin
    }
    
    init(newton value: Double) {
        self.newton = value
        self.unit = .Newton
    }
    
    init(rankine value: Double) {
        self.rankine = value
        self.unit = .Rankine
    }
    
    init(réaumur value: Double) {
        self.réaumur = value
        self.unit = .Réaumur
    }
    
    init(rømer value: Double) {
        self.rømer = value
        self.unit = .Rømer
    }
    
    var absoluteZero: Double {
        get {
            return unit.absoluteZero
        }
    }
    
    var symbol: String {
        get {
            return unit.rawValue
        }
    }
    
    var string: String {
        get {
            return getString(forUnit: self.unit)
        }
    }
    
    func getString(forUnit unit: TemperatureUnit) -> String {
        switch unit {
        case .Celcius:
            return String(format:"%f", self.celcius) + " " + unit.rawValue
        case .Delisle:
            return String(format:"%f", self.delisle) + " " + unit.rawValue
        case .Fahrenheit:
            return String(format:"%f", self.fahrenheit) + " " + unit.rawValue
        case .Kelvin:
            return String(format:"%f", self.kelvin) + " " + unit.rawValue
        case .Newton:
            return String(format:"%f", self.newton) + " " + unit.rawValue
        case .Rankine:
            return String(format:"%f", self.rankine) + " " + unit.rawValue
        case .Réaumur:
            return String(format:"%f", self.réaumur) + " " + unit.rawValue
        case .Rømer:
            return String(format:"%f", self.rømer) + " " + unit.rawValue
        }
    }
    
    func print() {
        println(self.string)
    }
    
    func print(asUnit unit: TemperatureUnit) {
        println(self.getString(forUnit: unit))
    }
    
}

    func print(asUnit unit: TemperatureUnit) {
        println(self.getString(forUnit: unit))
    }
    
}

prefix func - (temperature: Temperature) -> Temperature {
    var a = Temperature(kelvin: temperature.kelvin)
    a.unit = temperature.unit
    return a
}

func == (left: Temperature, right: Temperature) -> Bool {
    return left.kelvin == right.kelvin
}

func != (left: Temperature, right: Temperature) -> Bool {
    return !(left == right)
}

func += (inout left: Temperature, right: Temperature) {
    let originalUnit = left.unit
    left.kelvin += right.kelvin
    left.unit = originalUnit
}

func -= (inout left: Temperature, right: Temperature) {
    let originalUnit = left.unit
    left.kelvin -= right.kelvin
    left.unit = originalUnit
}

func + (left: Temperature, right: Temperature) -> Temperature {
    var a = Temperature(kelvin: left.kelvin + right.kelvin)
    a.unit = left.unit
    return a
}

func - (left: Temperature, right: Temperature) -> Temperature {
    var a = Temperature(kelvin: left.kelvin - right.kelvin)
    a.unit = left.unit
    return a
}

extension Int {
    
    var celcius: Temperature {
        get { return Temperature(celcius: Double(self)) }
    }
    
    var delisle: Temperature {
        get { return Temperature(delisle: Double(self)) }
    }
    
    var fahrenheit: Temperature {
        get { return Temperature(fahrenheit: Double(self)) }
    }
    
    var kelvin: Temperature {
        get { return Temperature(kelvin: Double(self)) }
    }
    
    var newton: Temperature {
        get { return Temperature(newton: Double(self)) }
    }
    
    var rankine: Temperature {
        get { return Temperature(rankine: Double(self)) }
    }
    
    var réaumur: Temperature {
        get { return Temperature(réaumur: Double(self)) }
    }
    
    var rømer: Temperature {
        get { return Temperature(rømer: Double(self)) }
    }
    
}

extension Double {
    
    var celcius: Temperature {
        get { return Temperature(celcius: self) }
    }
    
    var delisle: Temperature {
        get { return Temperature(delisle: self) }
    }
    
    var fahrenheit: Temperature {
        get { return Temperature(fahrenheit: self) }
    }
    
    var kelvin: Temperature {
        get { return Temperature(kelvin: self) }
    }
    
    var newton: Temperature {
        get { return Temperature(newton: self) }
    }
    
    var rankine: Temperature {
        get { return Temperature(rankine: self) }
    }
    
    var réaumur: Temperature {
        get { return Temperature(réaumur: self) }
    }
    
    var rømer: Temperature {
        get { return Temperature(rømer: self) }
    }
    
}

var zero = Temperature(celcius: 0.0)
zero.print(asUnit: .Celcius)
zero.print(asUnit: .Delisle)
zero.print(asUnit: .Fahrenheit)
zero.print(asUnit: .Kelvin)
zero.print(asUnit: .Newton)
zero.print(asUnit: .Rankine)
zero.print(asUnit: .Réaumur)
zero.print(asUnit: .Rømer)
(zero + 100.celcius).print() // Should print as celcius, as .unit should == .Celcius.
assert(100.celcius == (373.15).kelvin, "Failure.")
