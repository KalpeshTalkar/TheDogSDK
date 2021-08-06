//
//  AlertUtils.swift
//  DemoApp
//
//  Created by Kalpesh on 25/04/21.
//

import UIKit

extension UIViewController {

    /// Show alert.
    /// - Parameters:
    ///   - title: (Optional) Title for alert.
    ///   - message: (Option) Messahe for the alert.
    ///   - positiveButtonText: Positive button text.
    ///   - positiveActionStyle: Style for the positive button.
    ///   - negativeButtonText: Negative button text.
    ///   - negativeActionStyle: Style for the negative button.
    ///   - action: Click event fired on clicking positive action or negative action. The Bool value in the action is true if positive button is clicked.
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   positiveButtonText: String = "Okay",
                   positiveActionStyle: UIAlertAction.Style = .default,
                   negativeButtonText: String? = nil,
                   negativeActionStyle: UIAlertAction.Style? = .cancel,
                   action: ((Bool) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let positiveAction = UIAlertAction(title: positiveButtonText, style: positiveActionStyle) { (_) in
            action?(true)
        }
        alertController.addAction(positiveAction)

        if let negativeActionText = negativeButtonText, let negativeActionStyle = negativeActionStyle {
            let negativeAction = UIAlertAction(title: negativeActionText, style: negativeActionStyle) { (_) in
                action?(false)
            }
            alertController.addAction(negativeAction)
        }

        present(alertController, animated: true, completion: nil)
    }
}
