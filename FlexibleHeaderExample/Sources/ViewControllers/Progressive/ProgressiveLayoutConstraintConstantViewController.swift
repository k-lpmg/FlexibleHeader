//
//  ProgressiveLayoutConstraintConstantViewController.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import UIKit

import FlexibleHeader

final class ProgressiveLayoutConstraintConstantViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let flexibleHeader: FlexibleHeader
    private let headerContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    private let scrollView: UIScrollView
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    init() {
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        flexibleHeader = FlexibleHeader(scrollView: scrollView, maxHeight: 200, minHeight: 64, executantType: .threshold)
        flexibleHeader.translatesAutoresizingMaskIntoConstraints = false
        flexibleHeader.backgroundColor = .blue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        view.addSubview(flexibleHeader)
        view.addSubview(scrollView)
        flexibleHeader.addSubview(headerContentView)
        scrollView.addSubview(contentView)
        layout()
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        view.backgroundColor = .white
        title = "ProgressiveLayoutConstraintConstant"
    }
    
}

// MARK: - Layout

extension ProgressiveLayoutConstraintConstantViewController {
    
    private func layout() {
        flexibleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        flexibleHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        flexibleHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let flexibleHeaderHeight = flexibleHeader.heightAnchor.constraint(equalToConstant: 50)
        flexibleHeaderHeight.isActive = true
        flexibleHeader.configure(heightConstraint: flexibleHeaderHeight)
        
        scrollView.topAnchor.constraint(equalTo: flexibleHeader.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        layoutHeaderView()
        layoutScrollView()
    }
    
    private func layoutHeaderView() {
        headerContentView.centerXAnchor.constraint(equalTo: flexibleHeader.centerXAnchor).isActive = true
        headerContentView.centerYAnchor.constraint(equalTo: flexibleHeader.centerYAnchor).isActive = true
        headerContentView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        let headerContentViewWidth = headerContentView.widthAnchor.constraint(equalToConstant: 0)
        headerContentViewWidth.isActive = true
        
        let initialConstraintConstant = ProgressiveLayoutConstraintConstant(constraint: headerContentViewWidth, progress: 0.0, constant: 320)
        let finalConstraintConstant = ProgressiveLayoutConstraintConstant(constraint: headerContentViewWidth, progress: 1.0, constant: 0)
        flexibleHeader.appendProgressiveConstraintConstant(with: initialConstraintConstant)
        flexibleHeader.appendProgressiveConstraintConstant(with: finalConstraintConstant)
    }
    
    private func layoutScrollView() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 1600).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}
