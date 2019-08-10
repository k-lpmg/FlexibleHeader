//
//  SectionType.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import Foundation
import UIKit

import FlexibleHeader

enum SectionType: CaseIterable {
    typealias RowItem = (title: String, selectAction: (UIViewController) -> Void)
    
    case normalOrThreshold
    case custom
    case progressive
    
    var headerTitle: String {
        switch self {
        case .normalOrThreshold:
            return "Normal or Threshold"
        case .custom:
            return "Custom"
        case .progressive:
            return "Progressive"
        }
    }
    var numberOfRows: Int {
        return rowItems.count
    }
    private var rowItems: [RowItem] {
        var rowItems = [RowItem]()
        
        switch self {
        case .normalOrThreshold:
            rowItems.append(("FlexibleHeader", { viewController in
                let normalAction = UIAlertAction(title: "normal", style: .default, handler: { (_) in
                    let controller = FlexibleHeaderViewController(headerExecutantType: .normal)
                    viewController.navigationController?.pushViewController(controller, animated: true)
                })
                let thresholdAction = UIAlertAction(title: "threshold", style: .default, handler: { (_) in
                    let controller = FlexibleHeaderViewController(headerExecutantType: .threshold)
                    viewController.navigationController?.pushViewController(controller, animated: true)
                })
                let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
                viewController.alert(title: "Select FlexibleHeaderExecutantType", preferredStyle: .actionSheet, actions: [normalAction, thresholdAction, cancelAction])
            }))
            
            rowItems.append(("FlexibleHeaderScrollView", { viewController in
                let normalAction = UIAlertAction(title: "normal", style: .default, handler: { (_) in
                    let controller = FlexibleHeaderScrollViewController(headerExecutantType: .normal)
                    viewController.navigationController?.pushViewController(controller, animated: true)
                })
                let thresholdAction = UIAlertAction(title: "threshold", style: .default, handler: { (_) in
                    let controller = FlexibleHeaderScrollViewController(headerExecutantType: .threshold)
                    viewController.navigationController?.pushViewController(controller, animated: true)
                })
                let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
                viewController.alert(title: "Select FlexibleHeaderExecutantType", preferredStyle: .actionSheet, actions: [normalAction, thresholdAction, cancelAction])
            }))
        case .custom:
            rowItems.append(("Custom Height", { viewController in
                let controller = CustomHeightViewController()
                viewController.navigationController?.pushViewController(controller, animated: true)
            }))
            
            rowItems.append(("Custom Threshold", { viewController in
                let controller = CustomThresholdSettingVieWController()
                viewController.navigationController?.pushViewController(controller, animated: true)
            }))
        case .progressive:
            rowItems.append(("ProgressiveViewAttribute", { viewController in
                let controller = ProgressiveViewAttributeViewController()
                viewController.navigationController?.pushViewController(controller, animated: true)
            }))
            
            rowItems.append(("ProgressivewLayoutConstraintConstant", { viewController in
                let controller = ProgressiveLayoutConstraintConstantViewController()
                viewController.navigationController?.pushViewController(controller, animated: true)
            }))
        }
        
        return rowItems
    }
    
    func cellTitleFor(row: Int) -> String {
        return rowItems[row].title
    }
    
    func didSelectAt(row: Int, with viewController: UIViewController) {
        rowItems[row].selectAction(viewController)
    }
}
