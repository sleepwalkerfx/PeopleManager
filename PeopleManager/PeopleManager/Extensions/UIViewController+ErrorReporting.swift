//
//  UIViewController+ErrorReporting.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/8/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func presentAlertWithTitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
