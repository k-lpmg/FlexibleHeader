//
//  CustomHeightViewController.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import UIKit

import FlexibleHeader

final class CustomHeightViewController: UIViewController {
    
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
    
    /// SliderView
    private let sliderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let maxHeightTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MaxHeight"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let maxHeightSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = Const.defaultMaxHeight
        slider.minimumValue = Const.defaultMaxHeight
        slider.maximumValue = 200
        return slider
    }()
    private let maxHeightValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        label.text = "\(Int(Const.defaultMaxHeight))"
        return label
    }()
    private let minHeightTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MinHeight"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let minHeightSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = Const.defaultMinHeight
        slider.minimumValue = Const.defaultMinHeight
        slider.maximumValue = 64
        return slider
    }()
    private let minHeightValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        label.text = "\(Int(Const.defaultMinHeight))"
        return label
    }()
    
    // MARK: - Con(De)structor
    
    init() {
        flexibleHeaderScrollView = {
            let flexibleHeaderScrollView = FlexibleHeaderScrollView(headerMaxHeight: CGFloat(Const.defaultMaxHeight), headerMinHeight: CGFloat(Const.defaultMinHeight), headerExecutantType: .threshold)
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
        setSelector()
        view.addSubview(flexibleHeaderScrollView)
        view.addSubview(sliderView)
        flexibleHeaderScrollView.contentView.addSubview(topView)
        flexibleHeaderScrollView.contentView.addSubview(bottomView)
        sliderView.addSubview(maxHeightTitleLabel)
        sliderView.addSubview(maxHeightSlider)
        sliderView.addSubview(maxHeightValueLabel)
        sliderView.addSubview(minHeightTitleLabel)
        sliderView.addSubview(minHeightSlider)
        sliderView.addSubview(minHeightValueLabel)
        layout()
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        view.backgroundColor = .white
        title = "Custom Height"
    }
    
    private func setSelector() {
        maxHeightSlider.addTarget(self, action: #selector(maxHeightSliderValueChanged(_:)), for: .valueChanged)
        minHeightSlider.addTarget(self, action: #selector(minHeightSliderValueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Private selector
    
    @objc private func maxHeightSliderValueChanged(_ slider: UISlider) {
        maxHeightValueLabel.text = "\(Int(slider.value))"
        flexibleHeaderScrollView.header.maxHeight = CGFloat(slider.value)
    }
    
    @objc private func minHeightSliderValueChanged(_ slider: UISlider) {
        minHeightValueLabel.text = "\(Int(slider.value))"
        flexibleHeaderScrollView.header.minHeight = CGFloat(slider.value)
    }
    
}

// MARK: - Layout

extension CustomHeightViewController {
    
    private func layout() {
        flexibleHeaderScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        flexibleHeaderScrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        flexibleHeaderScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        flexibleHeaderScrollView.bottomAnchor.constraint(equalTo: sliderView.topAnchor).isActive = true
        
        sliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sliderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        layoutFlexibleHeaderScrollView()
        layoutSliderView()
    }
    
    private func layoutFlexibleHeaderScrollView() {
        topView.leadingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.leadingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.topAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 800).isActive = true
        
        bottomView.leadingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.leadingAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.bottomAnchor).isActive = true
    }
    
    private func layoutSliderView() {
        maxHeightTitleLabel.leadingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: 16).isActive = true
        maxHeightTitleLabel.topAnchor.constraint(equalTo: sliderView.topAnchor, constant: 64).isActive = true
        
        maxHeightSlider.centerYAnchor.constraint(equalTo: maxHeightTitleLabel.centerYAnchor).isActive = true
        maxHeightSlider.leadingAnchor.constraint(equalTo: maxHeightTitleLabel.trailingAnchor, constant: 16).isActive = true
        
        maxHeightValueLabel.centerYAnchor.constraint(equalTo: maxHeightTitleLabel.centerYAnchor).isActive = true
        maxHeightValueLabel.leadingAnchor.constraint(equalTo: maxHeightSlider.trailingAnchor, constant: 32).isActive = true
        maxHeightValueLabel.trailingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: -16).isActive = true
        maxHeightValueLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        minHeightTitleLabel.leadingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: 16).isActive = true
        minHeightTitleLabel.topAnchor.constraint(equalTo: maxHeightSlider.bottomAnchor, constant: 64).isActive = true
        minHeightTitleLabel.bottomAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: -64).isActive = true
        
        minHeightSlider.centerYAnchor.constraint(equalTo: minHeightTitleLabel.centerYAnchor).isActive = true
        minHeightSlider.leadingAnchor.constraint(equalTo: minHeightTitleLabel.trailingAnchor, constant: 16).isActive = true
        
        minHeightValueLabel.centerYAnchor.constraint(equalTo: minHeightTitleLabel.centerYAnchor).isActive = true
        minHeightValueLabel.leadingAnchor.constraint(equalTo: minHeightSlider.trailingAnchor, constant: 16).isActive = true
        minHeightValueLabel.trailingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: -16).isActive = true
        minHeightValueLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
}
