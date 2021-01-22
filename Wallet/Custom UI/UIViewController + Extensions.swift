//
//  UIViewController + Extensions.swift
//  Wallet
//
//  Created by Илья Карась on 18.11.2020.
//

import UIKit.UIViewController

extension UIViewController {
  
  func showAlert(with title: String?, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ок", style: .default)
    alert.addAction(ok)
    present(alert, animated: true)
  }
  
  func showAlert(with title: String?, message: String, completion: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ок", style: .default) { _ in
      completion()
    }
    alert.addAction(ok)
    present(alert, animated: true)
  }
}
