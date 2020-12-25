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
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.text = "4578"
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "546$"
        return label
    }()
//
//    lazy var cardNumberDot: UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }()

    lazy var cardNumberDotsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
//
//    lazy var cardNumberStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [cardNumberDotsStackView, cardNumberLabel])
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.spacing = 5
//        return stackView
//    }()
    
    lazy var cardNumberStackView: UIView = {
        let stackView = UIStackView()
        stackView.arrangedSubviews
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .purple
        return stackView
    }()
        
    // MARK:- Configure
    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(25)
            make.leading.equalTo(self).offset(25)
//            make.bottom.equalTo(cardNumberStackView).offset(-15)
            make.bottom.equalTo(cardNumberDotsStackView).offset(-15)
        }
    }

    private func configureCardNumber() {
//        addSubview(cardNumberStackView)
//        cardNumberStackView.snp.makeConstraints { make in
//            make.leading.equalTo(self).offset(25)
//        }
        
        let dotView = UIView()
        dotView.backgroundColor = .red
        for i in 0...3 {
            cardNumberDotsStackView.addArrangedSubview(dotView)
        }
     
        addSubview(cardNumberDotsStackView)
        cardNumberDotsStackView.snp.makeConstraints { make in
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
//        cardNumberDotsStackView.arrangedSubviews.forEach { $0.layer.cornerRadius = 2.5 }
        
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainBlack
        
        configureCardNumber()
        configureAmountLabel()
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
