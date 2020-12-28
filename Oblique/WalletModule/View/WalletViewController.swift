//
//  WalletViewController.swift
//  Oblique
//
//  Created by Максим Алексеев on 04.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

enum BottomSheetState {
    case full
    case initial
}

protocol WalletOutput: class {
    func reloadCollection()
}

class WalletViewController: UIViewController, WalletOutput {
    // MARK:- Dependencies
    var presenter: WalletPresenter!
    
    // MARK:- View
    private var bottomSheetViewController: WalletBottomSheetViewController!
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()
    
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = createCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = .transparentPurple
        pageControl.currentPageIndicatorTintColor = .transparentRed
        return pageControl
    }()
    
    // MARK:- Private properties
    private var botttomSheetState: BottomSheetState = .initial
    private let sheetHeight: CGFloat = UIScreen.main.bounds.height - 233
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressInterrupted: CGFloat = 0
    
    private let cellIdentifier = "CardCollectionViewCell"
    
    // MARK:- Properties
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBackgroundView = self.navigationController?.navigationBar.subviews.first
        navigationBackgroundView?.alpha = 0
        
        presenter.getWallets()
        
        configureBackgroundGradient()
        configureBottomSheetViewController()
        configureCollectionView()
        configurePageControl()
    }
    
    // MARK:- Configuration
    private func configureBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.mainRed.cgColor, UIColor.mainPurple.cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configureBottomSheetViewController() {
        bottomSheetViewController = WalletBottomSheetViewController()
        
        self.addChild(bottomSheetViewController)
        view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.view.layer.cornerRadius = 20
        
        bottomSheetViewController.view.frame = CGRect(x: 0, y: view.frame.minY + 288, width: view.frame.width, height: view.frame.height)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(sheetPanRecognizer(recognizer:)))
        bottomSheetViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func configureCollectionView() {
        cardsCollectionView.backgroundColor = .clear
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        cardsCollectionView.register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(cardsCollectionView)
        cardsCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.top.equalTo(view.safeAreaInsets.top)
            make.height.equalTo(225)
        }
    }
    
    private func configurePageControl() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(cardsCollectionView.snp.bottom).offset(15)
            make.height.equalTo(7)
        }
    }
    
    // MARK:- Private methods
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.cardsCollectionView.frame.size.width - 60), heightDimension: .absolute(160))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupFractionalWidth = 1
            let groupFractionalHeight: Float = 0.3
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
                heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = NSDirectionalEdgeInsets(top: 35, leading: 30, bottom: 5, trailing: 30)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
        
        return layout
    }
    
    private func startSheetTransition() {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1) {
                switch self.botttomSheetState {
                case .full:
                    self.bottomSheetViewController.view.frame.origin.y = self.view.frame.maxX                 
                case .initial:
                    self.bottomSheetViewController.view.frame.origin.y = self.view.frame.minY
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.runningAnimations.removeAll()
                
                switch self.botttomSheetState {
                case .full: self.botttomSheetState = .initial
                case .initial: self.botttomSheetState = .full
                }
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
                switch self.botttomSheetState {
                case .full:
                    self.bottomSheetViewController.view.layer.cornerRadius = 20
                case .initial:
                    self.bottomSheetViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            runningAnimations.forEach {
                $0.pauseAnimation()
                animationProgressInterrupted = $0.fractionComplete
            }
        }
    }
    
    private func continueSheetTransition(fraction: CGFloat) {
        runningAnimations.forEach {
            $0.fractionComplete = fraction + animationProgressInterrupted
        }
    }
    
    private func endSheetTransition() {
        runningAnimations.forEach {
            $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    // MARK:- WalletOutput
    func reloadCollection() {
        cardsCollectionView.reloadData()
    }
    
    // MARK:- Selectors
    @objc func sheetPanRecognizer(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startSheetTransition()
        case .changed:
            let translation = recognizer.translation(in: self.bottomSheetViewController.view)
            var fractionComplete = translation.y / view.frame.height

            switch botttomSheetState {
            case .full:
                break
            case .initial:
                fractionComplete = -fractionComplete
                
            }
            
            continueSheetTransition(fraction: fractionComplete)
        case .ended:
            endSheetTransition()
        default:
            break
        }
    }
}

// MARK:- UICollectionViewDelegate
extension WalletViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
    }
}

// MARK:- UICollectionViewDataSource
extension WalletViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter.wallets?.count ?? 1
        pageControl.numberOfPages = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CardsCollectionViewCell
        
        if let wallets = presenter.wallets {
            cell.cardView.nameLabel.text = wallets[indexPath.item].title
            cell.cardView.amountLabel.text = "\(wallets[indexPath.item].amount)$"
            cell.cardView.cardNumberLabel.text = "\(wallets[indexPath.item].number)"
        }
        
        return cell
    }
}
