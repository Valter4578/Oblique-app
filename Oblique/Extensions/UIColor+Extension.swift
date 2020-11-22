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
        return #colorLiteral(red: 0.4941176471, green: 0.2901960784, blue: 0.9294117647, alpha: 1)
    }
    
    static var accentPurple: UIColor {
        return #colorLiteral(red: 0.5725490196, green: 0.2901960784, blue: 0.9294117647, alpha: 1)
    }
    
    static var additionalPurple: UIColor {
        return #colorLiteral(red: 0.6392156863, green: 0.4666666667, blue: 1, alpha: 1)
    }
    
    static var lightFieldGray: UIColor {
        return #colorLiteral(red: 0.3137254902, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
    }
    
    static var mainRed: UIColor {
        return #colorLiteral(red: 1, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
    }
    
    static var textGray: UIColor {
        return #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
    }
    
    static var mainBlack: UIColor {
        return #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
    }
    
    static var shadowBlack: UIColor {
        return #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)
    }
    
    static var shadowWhite: UIColor {
        return #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
    }
}
