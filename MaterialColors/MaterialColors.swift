//
//  MaterialColors.swift
//
//  Based on https://github.com/daktales/MaterialDesignColorsSwift/
//
//  The MIT License (MIT)
//  Copyright © 2016 Sumant Manne
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init(rgba: UInt) {
        let rgba  = min(rgba, 0xFFFFFFFF)
        let red   = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let blue  = CGFloat((rgba & 0x0000FF00) >> 8)  / 255.0
        let alpha = CGFloat((rgba & 0x000000FF) >> 0)  / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public struct MaterialColor: Hashable {
    public let name: String
    public let color: UIColor
    public let textColor: UIColor
    
    public var hashValue: Int {
        return name.hashValue + color.hashValue + textColor.hashValue
    }
    
    init(name: String, color: UIColor, textColor: UIColor) {
        self.name = name
        self.color = color
        self.textColor = textColor
    }
    
    init(name: String, color: UInt, textColor: UInt) {
        self.init(name: name, color: UIColor(rgba: color), textColor: UIColor(rgba: textColor))
    }
}

public func ==(lhs: MaterialColor, rhs: MaterialColor) -> Bool {
    return  lhs.name == rhs.name &&
            lhs.color == rhs.color &&
            lhs.textColor == rhs.textColor
}

public class MaterialColorGroup: Hashable, CollectionType {
    public let name: String
    public let P50:  MaterialColor
    public let P100: MaterialColor
    public let P200: MaterialColor
    public let P300: MaterialColor
    public let P400: MaterialColor
    public let P500: MaterialColor
    public let P600: MaterialColor
    public let P700: MaterialColor
    public let P800: MaterialColor
    public let P900: MaterialColor
    
    public var colors: [MaterialColor] {
        return [P50, P100, P200, P300, P400, P500, P600, P700, P800, P900]
    }
    public var primaryColor: MaterialColor {
        return P500
    }
    
    public var hashValue: Int {
        return name.hashValue + colors.reduce(0) { $0 + $1.hashValue }
    }
    
    public var startIndex: Int {
        return 0
    }
    public var endIndex: Int {
        return colors.count
    }
    public subscript(i: Int) -> MaterialColor {
        return colors[i]
    }
    
    init(name: String,
        _ P50:  MaterialColor,
        _ P100: MaterialColor,
        _ P200: MaterialColor,
        _ P300: MaterialColor,
        _ P400: MaterialColor,
        _ P500: MaterialColor,
        _ P600: MaterialColor,
        _ P700: MaterialColor,
        _ P800: MaterialColor,
        _ P900: MaterialColor) {
        self.name = name
        
        self.P50  = P50
        self.P100 = P100
        self.P200 = P200
        self.P300 = P300
        self.P400 = P400
        self.P500 = P500
        self.P600 = P600
        self.P700 = P700
        self.P800 = P800
        self.P900 = P900
    }
    
    public func colorForName(name: String) -> MaterialColor? {
        return colors.filter { $0.name == name }.first
    }
}

public func ==(lhs: MaterialColorGroup, rhs: MaterialColorGroup) -> Bool {
    return  lhs.name == rhs.name &&
            lhs.colors == rhs.colors
}

public class MaterialColorGroupWithAccents: MaterialColorGroup {
    public let A100: MaterialColor
    public let A200: MaterialColor
    public let A400: MaterialColor
    public let A700: MaterialColor
    
    public var accents: [MaterialColor] {
        return [A100, A200, A400, A700]
    }
    
    public override var hashValue: Int {
        return super.hashValue + accents.reduce(0) { $0 + $1.hashValue }
    }
    
    public override var endIndex: Int {
        return colors.count + accents.count
    }
    public override subscript(i: Int) -> MaterialColor {
        return (colors + accents)[i]
    }
    
    init(name: String,
        _ P50:  MaterialColor,
        _ P100: MaterialColor,
        _ P200: MaterialColor,
        _ P300: MaterialColor,
        _ P400: MaterialColor,
        _ P500: MaterialColor,
        _ P600: MaterialColor,
        _ P700: MaterialColor,
        _ P800: MaterialColor,
        _ P900: MaterialColor,
        _ A100: MaterialColor,
        _ A200: MaterialColor,
        _ A400: MaterialColor,
        _ A700: MaterialColor
    ) {
        self.A100 = A100
        self.A200 = A200
        self.A400 = A400
        self.A700 = A700
        
        super.init(name: name, P50, P100, P200, P300, P400, P500, P600, P700, P800, P900)
    }
    
    public override func colorForName(name: String) -> MaterialColor? {
        return (colors + accents).filter { $0.name == name}.first
    }
}

func ==(lhs: MaterialColorGroupWithAccents, rhs: MaterialColorGroupWithAccents) -> Bool {
    return (lhs as MaterialColorGroup) == (rhs as MaterialColorGroup) &&
            lhs.accents == rhs.accents
}

public struct MaterialColors {
    public static let Red = MaterialColorGroupWithAccents(name: "Red",
        MaterialColor(name: "50",   color: 0xFDE0DCFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xF9BDBBFF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xF69988FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xF36C60FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xE84E40FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xE51C23FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0xDD191DFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0xD01716FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0xC41411FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0xB0120AFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100",	color: 0xFF7997FF, textColor: 0x000000DE),
        MaterialColor(name: "A200",	color: 0xFF5177FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A400",	color: 0xFF2D6FFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A700",	color: 0xE00032FF, textColor: 0xFFFFFFFF)
    )
    public static let Pink = MaterialColorGroupWithAccents(name: "Pink",
        MaterialColor(name: "50",   color: 0xFCE4ECFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xF8BBD0FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xF48FB1FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xF06292FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xEC407AFF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xE91E63FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0xD81B60FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0xC2185BFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0xAD1457FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x880E4FFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0xFF80ABFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xFF4081FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A400", color: 0xF50057FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A700", color: 0xC51162FF, textColor: 0xFFFFFFFF)
    )
    public static let Purple = MaterialColorGroupWithAccents(name: "Purple",
        MaterialColor(name: "50",   color: 0xF3E5F5FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xE1BEE7FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xCE93D8FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xBA68C8FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "400",  color: 0xAB47BCFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "500",  color: 0x9C27B0FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "600",  color: 0x8E24AAFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "700",  color: 0x7B1FA2FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0x6A1B9AFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x4A148CFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0xEA80FCFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xE040FBFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A400", color: 0xD500F9FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A700", color: 0xAA00FFFF, textColor: 0xFFFFFFFF)
    )
    public static let DeepPurple = MaterialColorGroupWithAccents(name: "Deep Purple",
        MaterialColor(name: "50",   color: 0xEDE7F6FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xD1C4E9FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xB39DDBFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x9575CDFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "400",  color: 0x7E57C2FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "500",  color: 0x673AB7FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "600",  color: 0x5E35B1FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "700",  color: 0x512DA8FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0x4527A0FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x311B92FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0xB388FFFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x7C4DFFFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A400", color: 0x651FFFFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A700", color: 0x6200EAFF, textColor: 0xFFFFFFDE)
    )
    public static let Indigo = MaterialColorGroupWithAccents(name: "Indigo",
        MaterialColor(name: "50",   color: 0xE8EAF6FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xC5CAE9FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0x9FA8DAFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x7986CBFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "400",  color: 0x5C6BC0FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "500",  color: 0x3F51B5FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "600",  color: 0x3949ABFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "700",  color: 0x303F9FFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0x283593FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x1A237EFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0x8C9EFFFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x536DFEFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A400", color: 0x3D5AFEFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A700", color: 0x304FFEFF, textColor: 0xFFFFFFDE)
    )
    public static let Blue = MaterialColorGroupWithAccents(name: "Blue",
        MaterialColor(name: "50",   color: 0xE7E9FDFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xD0D9FFFF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xAFBFFFFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x91A7FFFF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x738FFEFF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x5677FCFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0x4E6CEFFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0x455EDEFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0x3B50CEFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x2A36B1FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0xA6BAFFFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x6889FFFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A400", color: 0x4D73FFFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A700", color: 0x4D69FFFF, textColor: 0xFFFFFFFF)
    )
    public static let LightBlue = MaterialColorGroupWithAccents(name: "Light Blue",
        MaterialColor(name: "50",   color: 0xE1F5FEFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xB3E5FCFF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0x81D4FAFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x4FC3F7FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x29B6F6FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x03A9F4FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0x039BE5FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0x0288D1FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0x0277BDFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "900",  color: 0x01579BFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0x80D8FFFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x40C4FFFF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0x00B0FFFF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0x0091EAFF, textColor: 0xFFFFFFFF)
    )
    public static let Cyan = MaterialColorGroupWithAccents(name: "Cyan",
        MaterialColor(name: "50",   color: 0xE0F7FAFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xB2EBF2FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0x80DEEAFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x4DD0E1FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x26C6DAFF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x00BCD4FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0x00ACC1FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0x0097A7FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0x00838FFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "900",  color: 0x006064FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0x84FFFFFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x18FFFFFF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0x00E5FFFF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0x00B8D4FF, textColor: 0x000000DE)
    )
    public static let Teal = MaterialColorGroupWithAccents(name: "Teal", // Shoutout to Teal Deer!
        MaterialColor(name: "50",   color: 0xE0F2F1FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xB2DFDBFF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0x80CBC4FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x4DB6ACFF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x26A69AFF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x009688FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0x00897BFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0x00796BFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0x00695CFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x004D40FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0xA7FFEBFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x64FFDAFF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0x1DE9B6FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0x00BFA5FF, textColor: 0x000000DE)
    )
    public static let Green = MaterialColorGroupWithAccents(name: "Green",
        MaterialColor(name: "50",   color: 0xD0F8CEFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xA3E9A4FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0x72D572FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x42BD41FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x2BAF2BFF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x259B24FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0x0A8F08FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0x0A7E07FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0x056F00FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x0D5302FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "A100", color: 0xA2F78DFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0x5AF158FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0x14E715FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0x12C700FF, textColor: 0x000000DE)
    )
    public static let LightGreen = MaterialColorGroupWithAccents(name: "Light Green",
        MaterialColor(name: "50",   color: 0xF1F8E9FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xDCEDC8FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xC5E1A5FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xAED581FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x9CCC65FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x8BC34AFF, textColor: 0x000000DE),
        MaterialColor(name: "600",  color: 0x7CB342FF, textColor: 0x000000DE),
        MaterialColor(name: "700",  color: 0x689F38FF, textColor: 0x000000DE),
        MaterialColor(name: "800",  color: 0x558B2FFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "900",  color: 0x33691EFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A100", color: 0xCCFF90FF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xB2FF59FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0x76FF03FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0x64DD17FF, textColor: 0x000000DE)
    )
    public static let Lime = MaterialColorGroupWithAccents(name: "Lime",
        MaterialColor(name: "50",   color: 0xF9FBE7FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xF0F4C3FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xE6EE9CFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xDCE775FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xD4E157FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xCDDC39FF, textColor: 0x000000DE),
        MaterialColor(name: "600",  color: 0xC0CA33FF, textColor: 0x000000DE),
        MaterialColor(name: "700",  color: 0xAFB42BFF, textColor: 0x000000DE),
        MaterialColor(name: "800",  color: 0x9E9D24FF, textColor: 0x000000DE),
        MaterialColor(name: "900",  color: 0x827717FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A100", color: 0xF4FF81FF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xEEFF41FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0xC6FF00FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0xAEEA00FF, textColor: 0x000000DE)
    )
    public static let Yellow = MaterialColorGroupWithAccents(name: "Yellow",
        MaterialColor(name: "50",   color: 0xFFFDE7FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xFFF9C4FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xFFF59DFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xFFF176FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xFFEE58FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xFFEB3BFF, textColor: 0x000000DE),
        MaterialColor(name: "600",  color: 0xFDD835FF, textColor: 0x000000DE),
        MaterialColor(name: "700",  color: 0xFBC02DFF, textColor: 0x000000DE),
        MaterialColor(name: "800",  color: 0xF9A825FF, textColor: 0x000000DE),
        MaterialColor(name: "900",  color: 0xF57F17FF, textColor: 0x000000DE),
        MaterialColor(name: "A100", color: 0xFFFF8DFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xFFFF00FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0xFFEA00FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0xFFD600FF, textColor: 0x000000DE)
    )
    public static let Amber = MaterialColorGroupWithAccents(name: "Amber",
        MaterialColor(name: "50",   color: 0xFFF8E1FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xFFECB3FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xFFE082FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xFFD54FFF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xFFCA28FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xFFC107FF, textColor: 0x000000DE),
        MaterialColor(name: "600",  color: 0xFFB300FF, textColor: 0x000000DE),
        MaterialColor(name: "700",  color: 0xFFA000FF, textColor: 0x000000DE),
        MaterialColor(name: "800",  color: 0xFF8F00FF, textColor: 0x000000DE),
        MaterialColor(name: "900",  color: 0xFF6F00FF, textColor: 0x000000DE),
        MaterialColor(name: "A100", color: 0xFFE57FFF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xFFD740FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0xFFC400FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0xFFAB00FF, textColor: 0x000000DE)
    )
    public static let Orange = MaterialColorGroupWithAccents(name: "Orange",
        MaterialColor(name: "50",   color: 0xFFF3E0FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xFFE0B2FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xFFCC80FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xFFB74DFF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xFFA726FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xFF9800FF, textColor: 0x000000DE),
        MaterialColor(name: "600",  color: 0xFB8C00FF, textColor: 0x000000DE),
        MaterialColor(name: "700",  color: 0xF57C00FF, textColor: 0x000000DE),
        MaterialColor(name: "800",  color: 0xEF6C00FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "900",  color: 0xE65100FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A100", color: 0xFFD180FF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xFFAB40FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0xFF9100FF, textColor: 0x000000DE),
        MaterialColor(name: "A700", color: 0xFF6D00FF, textColor: 0x00000000)
    )
    public static let DeepOrange = MaterialColorGroupWithAccents(name: "Deep Orange",
        MaterialColor(name: "50",   color: 0xFBE9E7FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xFFCCBCFF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xFFAB91FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xFF8A65FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xFF7043FF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0xFF5722FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0xF4511EFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "700",  color: 0xE64A19FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "800",  color: 0xD84315FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "900",  color: 0xBF360CFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A100", color: 0xFF9E80FF, textColor: 0x000000DE),
        MaterialColor(name: "A200", color: 0xFF6E40FF, textColor: 0x000000DE),
        MaterialColor(name: "A400", color: 0xFF3D00FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "A700", color: 0xDD2C00FF, textColor: 0xFFFFFFFF)
    )
    public static let Brown = MaterialColorGroup(name: "Brown",
        MaterialColor(name: "50",   color: 0xEFEBE9FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xD7CCC8FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xBCAAA4FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xA1887FFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "400",  color: 0x8D6E63FF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "500",  color: 0x795548FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "600",  color: 0x6D4C41FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "700",  color: 0x5D4037FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0x4E342EFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x3E2723FF, textColor: 0xFFFFFFDE)
    )
    public static let Grey = MaterialColorGroup(name: "Grey",
        MaterialColor(name: "50",   color: 0xFAFAFAFF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xF5F5F5FF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xEEEEEEFF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0xE0E0E0FF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0xBDBDBDFF, textColor: 0x000000DE),
        MaterialColor(name: "500",  color: 0x9E9E9EFF, textColor: 0x000000DE),
        MaterialColor(name: "600",  color: 0x757575FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "700",  color: 0x616161FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0x424242FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x212121FF, textColor: 0xFFFFFFDE)
    )
    public static let BlueGrey = MaterialColorGroup(name: "Blue Grey",
        MaterialColor(name: "50",   color: 0xECEFF1FF, textColor: 0x000000DE),
        MaterialColor(name: "100",  color: 0xCFD8DCFF, textColor: 0x000000DE),
        MaterialColor(name: "200",  color: 0xB0BEC5FF, textColor: 0x000000DE),
        MaterialColor(name: "300",  color: 0x90A4AEFF, textColor: 0x000000DE),
        MaterialColor(name: "400",  color: 0x78909CFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "500",  color: 0x607D8BFF, textColor: 0xFFFFFFFF),
        MaterialColor(name: "600",  color: 0x546E7AFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "700",  color: 0x455A64FF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "800",  color: 0x37474FFF, textColor: 0xFFFFFFDE),
        MaterialColor(name: "900",  color: 0x263238FF, textColor: 0xFFFFFFDE)
    )
    public static let Black = MaterialColor(name: "Black", color: 0x000000FF, textColor: 0xFFFFFFDE)
    public static let White = MaterialColor(name: "White", color: 0xFFFFFFFF, textColor: 0x000000DE)
    
    
    public static let accentedColorGroups: [MaterialColorGroupWithAccents] = [
        Red, Pink, Purple, DeepPurple, Indigo, Blue, LightBlue, Cyan, Teal,
        Green, LightGreen, Lime, Yellow, Amber, Orange, DeepOrange,
    ]
    public static let unaccentedColorGroups: [MaterialColorGroup] = [
        Brown, Grey, BlueGrey,
    ]
    public static let colorGroups: [MaterialColorGroup] = accentedColorGroups + unaccentedColorGroups
    
    public static let P50: [MaterialColor] = [
        Red.P50, Pink.P50, Purple.P50, DeepPurple.P50, Indigo.P50,
        Blue.P50, LightBlue.P50, Cyan.P50, Teal.P50, Green.P50,
        LightGreen.P50, Lime.P50, Yellow.P50, Amber.P50, Orange.P50,
        DeepOrange.P50, Brown.P50, Grey.P50, BlueGrey.P50,
    ]
    public static let P100: [MaterialColor] = [
        Red.P100, Pink.P100, Purple.P100, DeepPurple.P100, Indigo.P100,
        Blue.P100, LightBlue.P100, Cyan.P100, Teal.P100, Green.P100,
        LightGreen.P100, Lime.P100, Yellow.P100, Amber.P100, Orange.P100,
        DeepOrange.P100, Brown.P100, Grey.P100, BlueGrey.P100,
    ]
    public static let P200: [MaterialColor] = [
        Red.P200, Pink.P200, Purple.P200, DeepPurple.P200, Indigo.P200,
        Blue.P200, LightBlue.P200, Cyan.P200, Teal.P200, Green.P200,
        LightGreen.P200, Lime.P200, Yellow.P200, Amber.P200, Orange.P200,
        DeepOrange.P200, Brown.P200, Grey.P200, BlueGrey.P200,
    ]
    public static let P300: [MaterialColor] = [
        Red.P300, Pink.P300, Purple.P300, DeepPurple.P300, Indigo.P300,
        Blue.P300, LightBlue.P300, Cyan.P300, Teal.P300, Green.P300,
        LightGreen.P300, Lime.P300, Yellow.P300, Amber.P300, Orange.P300,
        DeepOrange.P300, Brown.P300, Grey.P300, BlueGrey.P300,
    ]
    public static let P400: [MaterialColor] = [
        Red.P400, Pink.P400, Purple.P400, DeepPurple.P400, Indigo.P400,
        Blue.P400, LightBlue.P400, Cyan.P400, Teal.P400, Green.P400,
        LightGreen.P400, Lime.P400, Yellow.P400, Amber.P400, Orange.P400,
        DeepOrange.P400, Brown.P400, Grey.P400, BlueGrey.P400,
    ]
    public static let P500: [MaterialColor] = [
        Red.P500, Pink.P500, Purple.P500, DeepPurple.P500, Indigo.P500,
        Blue.P500, LightBlue.P500, Cyan.P500, Teal.P500, Green.P500,
        LightGreen.P500, Lime.P500, Yellow.P500, Amber.P500, Orange.P500,
        DeepOrange.P500, Brown.P500, Grey.P500, BlueGrey.P500,
    ]
    public static let P600: [MaterialColor] = [
        Red.P600, Pink.P600, Purple.P600, DeepPurple.P600, Indigo.P600,
        Blue.P600, LightBlue.P600, Cyan.P600, Teal.P600, Green.P600,
        LightGreen.P600, Lime.P600, Yellow.P600, Amber.P600, Orange.P600,
        DeepOrange.P600, Brown.P600, Grey.P600, BlueGrey.P600,
    ]
    public static let P700: [MaterialColor] = [
        Red.P700, Pink.P700, Purple.P700, DeepPurple.P700, Indigo.P700,
        Blue.P700, LightBlue.P700, Cyan.P700, Teal.P700, Green.P700,
        LightGreen.P700, Lime.P700, Yellow.P700, Amber.P700, Orange.P700,
        DeepOrange.P700, Brown.P700, Grey.P700, BlueGrey.P700,
    ]
    public static let P800: [MaterialColor] = [
        Red.P800, Pink.P800, Purple.P800, DeepPurple.P800, Indigo.P800,
        Blue.P800, LightBlue.P800, Cyan.P800, Teal.P800, Green.P800,
        LightGreen.P800, Lime.P800, Yellow.P800, Amber.P800, Orange.P800,
        DeepOrange.P800, Brown.P800, Grey.P800, BlueGrey.P800,
    ]
    public static let P900: [MaterialColor] = [
        Red.P900, Pink.P900, Purple.P900, DeepPurple.P900, Indigo.P900,
        Blue.P900, LightBlue.P900, Cyan.P900, Teal.P900, Green.P900,
        LightGreen.P900, Lime.P900, Yellow.P900, Amber.P900, Orange.P900,
        DeepOrange.P900, Brown.P900, Grey.P900, BlueGrey.P900,
    ]
    public static let A100: [MaterialColor] = [
        Red.A100, Pink.A100, Purple.A100, DeepPurple.A100, Indigo.A100,
        Blue.A100, LightBlue.A100, Cyan.A100, Teal.A100, Green.A100,
        LightGreen.A100, Lime.A100, Yellow.A100, Amber.A100, Orange.A100,
        DeepOrange.A100,
    ]
    public static let A200: [MaterialColor] = [
        Red.A200, Pink.A200, Purple.A200, DeepPurple.A200, Indigo.A200,
        Blue.A200, LightBlue.A200, Cyan.A200, Teal.A200, Green.A200,
        LightGreen.A200, Lime.A200, Yellow.A200, Amber.A200, Orange.A200,
        DeepOrange.A200,
    ]
    public static let A400: [MaterialColor] = [
        Red.A400, Pink.A400, Purple.A400, DeepPurple.A400, Indigo.A400,
        Blue.A400, LightBlue.A400, Cyan.A400, Teal.A400, Green.A400,
        LightGreen.A400, Lime.A400, Yellow.A400, Amber.A400, Orange.A400,
        DeepOrange.A400,
    ]
    public static let A700: [MaterialColor] = [
        Red.A700, Pink.A700, Purple.A700, DeepPurple.A700, Indigo.A700,
        Blue.A700, LightBlue.A700, Cyan.A700, Teal.A700, Green.A700,
        LightGreen.A700, Lime.A700, Yellow.A700, Amber.A700, Orange.A700,
        DeepOrange.A700,
    ]
}
