//
//  SmallTextWidget.swift
//  Oblique
//
//  Created by Максим Алексеев on 30.12.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class SmallTextWidget: UIView {
    // MARK:- Properties
    var contentLabelColor: UIColor = .white {
        didSet {
            contentTextLabel.textColor = contentLabelColor
        }
    }
    
    var contentLabelFont: UIFont = .systemFont(ofSize: 36, weight: .semibold) {
        didSet {
            contentTextLabel.font = contentLabelFont
        }
    }
    
    // MARK:- View
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    lazy var contentTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = contentLabelColor
        label.font = contentLabelFont
        return label
    }()
    
    // MARK:- Configure
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(self).offset(15)
        }
    }
    
    private func configureContentTextLabel() {
        addSubview(contentTextLabel)
        contentTextLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTitleLabel()
        configureContentTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
