//
//  CardsCollectionViewCell.swift
//  Oblique
//
//  Created by Максим Алексеев on 26.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class CardsCollectionViewCell: UICollectionViewCell {
    //MARK:- Views
    let cardView = CardView()
    
    // MARK:- Configures
    private func configureCardView() {
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardView.layer.cornerRadius = 20
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCardView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
