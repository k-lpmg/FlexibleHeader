//
//  CustomThresholdSettingViewController.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import UIKit

final class CustomThresholdSettingVieWController: UIViewController {
    
    // MARK: - Const
    
    private enum Const {
        static let defaultThreshold: Double = 20
    }
    
    // MARK: - UI Components
    
    private let hiddenThresholdTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = "hiddenThreshold"
        return label
    }()
    private let hiddenThresholdValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        label.text = "\(Int(Const.defaultThreshold))"
        return label
    }()
    private let hiddenThresholdStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 0
        stepper.maximumValue = 300
        stepper.value = Const.defaultThreshold
        stepper.stepValue = 10
        return stepper
    }()
    private let showThresholdTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = "showThreshold"
        return label
    }()
    private let showThresholdValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        label.text = "\(Int(Const.defaultThreshold))"
        return label
    }()
    private let showThresholdStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 0
        stepper.maximumValue = 300
        stepper.value = Const.defaultThreshold
        stepper.stepValue = 10
        return stepper
    }()
    private let pushButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Push CustomThresholdViewController", for: .normal)
        return button
    }()
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        setSelector()
        view.addSubview(hiddenThresholdTitleLabel)
        view.addSubview(hiddenThresholdValueLabel)
        view.addSubview(hiddenThresholdStepper)
        view.addSubview(showThresholdTitleLabel)
        view.addSubview(showThresholdValueLabel)
        view.addSubview(showThresholdStepper)
        view.addSubview(pushButton)
        layout()
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        view.backgroundColor = .white
    }
    
    private func setSelector() {
        hiddenThresholdStepper.addTarget(self, action: #selector(hiddenThresholdStepperValueChanged(_:)), for: .valueChanged)
        showThresholdStepper.addTarget(self, action: #selector(showThresholdStepperValueChanged(_:)), for: .valueChanged)
        pushButton.addTarget(self, action: #selector(pushButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Private selector
    
    @objc private func hiddenThresholdStepperValueChanged(_ stepper: UIStepper) {
        hiddenThresholdValueLabel.text = "\(Int(stepper.value))"
    }
    
    @objc private func showThresholdStepperValueChanged(_ stepper: UIStepper) {
        showThresholdValueLabel.text = "\(Int(stepper.value))"
    }
    
    @objc private func pushButtonClicked() {
        let controller = CustomThresholdViewController(hiddenThreshold: CGFloat(hiddenThresholdStepper.value), showThreshold: CGFloat(showThresholdStepper.value))
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - Layout

extension CustomThresholdSettingVieWController {
    
    private func layout() {
        hiddenThresholdTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        hiddenThresholdTitleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 64).isActive = true
        
        hiddenThresholdValueLabel.centerYAnchor.constraint(equalTo: hiddenThresholdTitleLabel.centerYAnchor).isActive = true
        hiddenThresholdValueLabel.trailingAnchor.constraint(equalTo: hiddenThresholdStepper.leadingAnchor, constant: -16).isActive = true
        
        hiddenThresholdStepper.centerYAnchor.constraint(equalTo: hiddenThresholdTitleLabel.centerYAnchor).isActive = true
        hiddenThresholdStepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        showThresholdTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        showThresholdTitleLabel.topAnchor.constraint(equalTo: hiddenThresholdTitleLabel.bottomAnchor, constant: 32).isActive = true
        
        showThresholdValueLabel.centerYAnchor.constraint(equalTo: showThresholdTitleLabel.centerYAnchor).isActive = true
        showThresholdValueLabel.trailingAnchor.constraint(equalTo: showThresholdStepper.leadingAnchor, constant: -16).isActive = true
        
        showThresholdStepper.centerYAnchor.constraint(equalTo: showThresholdTitleLabel.centerYAnchor).isActive = true
        showThresholdStepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.topAnchor.constraint(equalTo: showThresholdTitleLabel.bottomAnchor, constant: 64).isActive = true
    }
    
}
