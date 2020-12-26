//
//  UIView+Extension.swift
//  Oblique
//
//  Created by Максим Алексеев on 15.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(colors: [UIColor?] = [.shadowBlack, .shadowWhite], opacity: Float = 0.5, offsets: [CGSize], radius: CGFloat = 10) {
        var layers: [CALayer] = []
        
        if let firstColor = colors[0] {
            let firstLayer = CALayer()
            firstLayer.shadowColor = firstColor.cgColor
            firstLayer.shadowOffset = offsets[0]
            layers.append(firstLayer)
        }
        
        if let secondColor = colors[1] {
            let secondLayer = CALayer()
            secondLayer.shadowColor = secondColor.cgColor
            secondLayer.shadowOffset = offsets[1]
            layers.append(secondLayer)
        }

        layers.forEach {
            $0.masksToBounds = false
            $0.shadowOpacity = opacity
            $0.shadowRadius = radius
            $0.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            $0.shouldRasterize = true
            $0.rasterizationScale = 1
            
//            self.layer.sublayers = nil
            self.layer.addSublayer($0)
            $0.zPosition = -1
        }
    }
}

