//
//  BigWidget.swift
//  Oblique
//
//  Created by Максим Алексеев on 30.12.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class BigWidget: UIView {
    // MARK:- Properties
    
    // MARK:- Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var contentView = UIView()
    
    // MARK:- Configure
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(15)
            make.top.equalTo(self).offset(5)
        }
    }
    
    private func configureContentView() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
        contentView.backgroundColor = .red
        titleLabel.text = "Months expense"
        
        configureTitleLabel()
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
