//
//  UITextField+Extension.swift
//  Oblique
//
//  Created by Максим Алексеев on 20.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UITextField {
    func setPlaceholderPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
