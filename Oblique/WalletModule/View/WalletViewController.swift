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

class WalletViewController: UIViewController {
    // MARK:- View
    var bottomSheetViewController: WalletBottomSheetViewController!
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        
        return view
    }()
    
    // MARK:- Private properties
    private var botttomSheetState: BottomSheetState = .initial
    private let sheetHeight: CGFloat = UIScreen.main.bounds.height - 233
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressInterrupted: CGFloat = 0
    
    
    // MARK:- Properties
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBackgroundView = self.navigationController?.navigationBar.subviews.first
        navigationBackgroundView?.alpha = 0
        
        view.backgroundColor = .mainPurple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureBottomSheetViewController()
        
        
    }
    
    // MARK:- Configuration
    
    private func configureBottomSheetViewController() {
        bottomSheetViewController = WalletBottomSheetViewController()
        
        self.addChild(bottomSheetViewController)
        view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.view.layer.cornerRadius = 20
        
        bottomSheetViewController.view.frame = CGRect(x: 0, y: view.frame.maxX, width: view.frame.width, height: view.frame.height)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(sheetPanRecognizer(recognizer:)))
        bottomSheetViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    // MARK:- Private methods
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
            print($0.fractionComplete)
        }
    }
    
    private func endSheetTransition() {
        runningAnimations.forEach {
            $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    // MARK:- Selectors
    @objc func sheetPanRecognizer(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startSheetTransition()
        case .changed:
            let translation = recognizer.translation(in: self.bottomSheetViewController.view)
//            print(translation.y.magnitude)
            var fractionComplete = translation.y / view.frame.height
//            print(fractionComplete)

            switch botttomSheetState {
            case .full:
                break
            case .initial:
                fractionComplete = -fractionComplete
                
            }
            
            print(fractionComplete)
            continueSheetTransition(fraction: fractionComplete)
            
        case .ended:
            endSheetTransition()
        default:
            break
        }
    }
}
