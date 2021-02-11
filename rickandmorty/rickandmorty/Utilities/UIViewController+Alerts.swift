//
//  UIViewController+Alerts.swift
//  rickandmorty
//
//  Created by Pavel Kozlov on 11.02.2021.
//

import UIKit

extension UIViewController {
    func popupAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in} )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
