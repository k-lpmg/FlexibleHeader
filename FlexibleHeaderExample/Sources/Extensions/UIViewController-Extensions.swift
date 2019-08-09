//
//  UIViewController-Extensions.swift
//  FlexibleHeaderExample
//
//  Created by K on 05/08/2019.
//  Copyright © 2019 lpmg. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @discardableResult
    func alert(title: String? = nil,
               message: String? = nil,
               preferredStyle: UIAlertController.Style = .alert,
               actions: [UIAlertAction]?,
               textFieldHandlers: [((UITextField) -> Void)]? = nil,
               completion: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = actions {
            actions.forEach({ (action) in
                alert.addAction(action)
            })
        }
        if let textFieldHandlers = textFieldHandlers {
            textFieldHandlers.forEach { (handler) in
                alert.addTextField(configurationHandler: handler)
            }
        }
        present(alert, animated: true, completion: completion)
        return alert
    }
    
}
