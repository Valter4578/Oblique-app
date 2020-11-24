//
//  LaunchViewController.swift
//  Oblique
//
//  Created by Максим Алексеев on 23.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class LaunchViewController: UIViewController {
    // MARK:- Dependencies
    var presenter: LaunchInput! 
    
    // MARK:- Views
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "oblique")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .light)
        label.textColor = .white
        label.text = "Oblique"
        return label
    }()

    // MARK:- Lifecycle 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBlack
        
        configureTitleLabel()
        configureImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.logIn()
    }
    
    // MARK:- Configure
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(100)
        }
    }
    
    private func configureImageView() {
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(titleLabel.snp.top).offset(-50)
        }
    }
    
}
