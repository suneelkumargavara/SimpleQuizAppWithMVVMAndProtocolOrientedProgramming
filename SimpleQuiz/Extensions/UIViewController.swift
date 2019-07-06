//
//  UIViewController.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

extension UIViewController {
    
    struct AlertControllerData {
        let title: String
        let message: String
        let alertActions: [UIAlertAction]
    }
    
    func showAlert(_ alertData: AlertControllerData) {
        let alertController = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: .alert)
        alertData.alertActions.forEach({alertController.addAction($0)})
        self.show(alertController, sender: nil)
    }
}
