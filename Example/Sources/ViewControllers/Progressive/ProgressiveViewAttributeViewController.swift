//
//  ProgressiveViewAttributeViewController.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import UIKit

import FlexibleHeader

final class ProgressiveViewAttributeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let flexibleHeader: FlexibleHeader
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
        flexibleHeader = FlexibleHeader(scrollView: scrollView, maxHeight: 128, minHeight: 0, executantType: .threshold)
        flexibleHeader.translatesAutoresizingMaskIntoConstraints = false
        flexibleHeader.backgroundColor = .blue
        super.init(nibName: nil, bundle: nil)
        
        configureProgressiveAttribute()
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
        scrollView.addSubview(contentView)
        layout()
    }
    
    // MARK: - Private methods
    
    private func configureProgressiveAttribute() {
        let initialAttribute = ProgressiveViewAttribute(view: flexibleHeader, progress: 0.0, alpha: 1.0)
        let finalAttribute = ProgressiveViewAttribute(view: flexibleHeader, progress: 1.0, alpha: 0.0)
        flexibleHeader.appendProgressiveViewAttribute(with: initialAttribute)
        flexibleHeader.appendProgressiveViewAttribute(with: finalAttribute)
    }
    
    private func setProperties() {
        view.backgroundColor = .white
        title = "ProgressiveViewAttribute"
    }
    
}

// MARK: - Layout

extension ProgressiveViewAttributeViewController {
    
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
        
        layoutScrollView()
    }
    
    private func layoutScrollView() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 1600).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}
