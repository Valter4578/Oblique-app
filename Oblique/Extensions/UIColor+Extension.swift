//
//  UIColor+Extension.swift
//  Oblique
//
//  Created by Максим Алексеев on 15.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK:- Methods
    static func setAsHex(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK:- Properties
    static var mainPurple: UIColor {
        return setAsHex(hex: "7E4AED")
    }
    
    static var accentPurple: UIColor {
        return setAsHex(hex: "924AED")
    }
    
    static var lightFieldGray: UIColor {
        return setAsHex(hex: "505050")
    }
    
    static var textGray: UIColor {
        return setAsHex(hex: "9B9B9B")
    }
    
    static var mainBlack: UIColor {
        return setAsHex(hex: "3A3A3A")
    }
}
