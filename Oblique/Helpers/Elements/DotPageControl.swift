//
//  DotPageControl.swift
//  Oblique
//
//  Created by Максим Алексеев on 26.12.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class DotPageControl: UIView {
    // MARK:- Public propeties
    var currentElement: Int = 0 {
        didSet {
            selectIndex(currentElement)
        }
    }
    
    var numberOfElements: Int = 0
    
    var elementTintColor: UIColor = .white
    var selctedElementTintColor: UIColor = .lightGray
    
    var sizeOfElement: CGSize = CGSize(width: 7, height: 7)
    var sizeOfSelectedElement: CGSize = CGSize(width: 15, height: 7)
    
    var spacingBetweenElements: CGFloat = 5.0 {
        didSet {
            stackView?.spacing = spacingBetweenElements
        }
    }
    
    // MARK:- Private properties
    private var dotButtons: [UIButton] = []
    
    // MARK:- Views
    var stackView: UIStackView?
    
    // MARK:- Private methods
    private func selectIndex(_ index: Int) {
        let selectedButton = stackView?.subviews[index]
        UIView.animate(withDuration: 0.1) {
            selectedButton?.frame.size = self.sizeOfSelectedElement
            selectedButton?.backgroundColor = self.selctedElementTintColor
        }
        
    }
    
    // MARK:- Configure
    private func configureStackView() {
        for i in 0...numberOfElements {
            let dotButton = UIButton()
            dotButton.backgroundColor = elementTintColor
            dotButtons.append(dotButton)
        }
        
        stackView = UIStackView(arrangedSubviews: dotButtons)
        stackView?.axis = .horizontal
        stackView?.distribution = .fillEqually
        stackView?.spacing = spacingBetweenElements
    }
    
    
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
