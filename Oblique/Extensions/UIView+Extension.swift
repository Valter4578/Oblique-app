//
//  UIView+Extension.swift
//  Oblique
//
//  Created by Максим Алексеев on 15.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    func gradientColors(colors: [UIColor], startPoint: NSNumber = 0.0, endPoint: NSNumber = 1.1) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [startPoint, endPoint]
        gradient.colors = colors.map { $0.cgColor }

        return gradient
    }
}

