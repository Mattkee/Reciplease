//
//  UIViewControler + Extension.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 22/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Alerts
extension UIViewController : DisplayAlert {
    func showAlert(title: String, message: String) {
        let alerteVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerteVC.addAction(action)
        present(alerteVC, animated: true, completion: nil)
    }
}
