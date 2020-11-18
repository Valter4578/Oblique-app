//
//  UIView+Extension.swift
//  Oblique
//
//  Created by Максим Алексеев on 15.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(colors: [UIColor] = [.shadowBlack, .shadowWhite], opacity: Float = 0.5, offsets: [CGSize], radius: CGFloat = 1) {
        let blackLayer = CALayer()
        blackLayer.shadowColor = colors[0].cgColor
        blackLayer.shadowOffset = offsets[0]
        
        let whiteLayer = CALayer()
        whiteLayer.shadowColor = colors[1].cgColor
        whiteLayer.shadowOffset = CGSize(width: -10, height: -10)

        
        let layers = [blackLayer, whiteLayer]
        
        layers.forEach {
            $0.masksToBounds = false
            $0.shadowOpacity = opacity
            $0.shadowRadius = radius
            $0.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            $0.shouldRasterize = true
            $0.rasterizationScale = 1
            
            self.layer.addSublayer($0)
            $0.zPosition = -3
        }
    }
}

