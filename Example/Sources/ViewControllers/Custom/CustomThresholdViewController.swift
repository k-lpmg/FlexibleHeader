//
//  CustomThresholdViewController.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import UIKit

import FlexibleHeader

final class CustomThresholdViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Const {
        static let defaultMaxHeight: Float = 64
        static let defaultMinHeight: Float = 0
    }
    
    // MARK: - UI Components
    
    private let flexibleHeaderScrollView: FlexibleHeaderScrollView
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - Con(De)structor
    
    init(hiddenThreshold: CGFloat, showThreshold: CGFloat) {
        flexibleHeaderScrollView = {
            let flexibleHeaderScrollView = FlexibleHeaderScrollView(headerMaxHeight: 64, headerMinHeight: 0, headerExecutantType: .customThreshold(hiddenThreshold: hiddenThreshold, showThreshold: showThreshold))
            flexibleHeaderScrollView.translatesAutoresizingMaskIntoConstraints = false
            flexibleHeaderScrollView.header.backgroundColor = .blue
            return flexibleHeaderScrollView
        }()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        view.addSubview(flexibleHeaderScrollView)
        flexibleHeaderScrollView.contentView.addSubview(topView)
        flexibleHeaderScrollView.contentView.addSubview(bottomView)
        layout()
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        view.backgroundColor = .white
        title = "Custom Threshold"
    }
    
}

// MARK: - Layout

extension CustomThresholdViewController {
    
    private func layout() {
        flexibleHeaderScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        flexibleHeaderScrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        flexibleHeaderScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        flexibleHeaderScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        layoutFlexibleHeaderScrollView()
    }
    
    private func layoutFlexibleHeaderScrollView() {
        topView.leadingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.leadingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.topAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 550).isActive = true
        
        bottomView.leadingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.leadingAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 550).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.bottomAnchor).isActive = true
    }
    
}
