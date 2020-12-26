//
//  CardView.swift
//  Oblique
//
//  Created by Максим Алексеев on 17.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class CardView: UIView {
    // MARK:- Properties
    
    // MARK:- Views
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Main card"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "546$"
        return label
    }()
        
    // MARK:- Configure
    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(25)
            make.leading.equalTo(self).offset(25)
            make.bottom.equalTo(cardNumberLabel).offset(-25)
        }
    }
    
    private func configureNumberLabel() {
        addSubview(cardNumberLabel)
        cardNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(25)
        }
    }
    
    
    private func configureAmountLabel() {
        addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(25)
            make.bottom.bottom.equalTo(-15)
        }
    }
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
            
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainBlack
        
        configureAmountLabel()
        configureNumberLabel()
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
