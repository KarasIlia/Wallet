//
//  RoundedTextField.swift
//  Wallet
//
//  Created by Илья Карась on 22.11.2020.
//

import UIKit

class RoundedTextField: UITextField {
  
  override func draw(_ rect: CGRect) {
    roundCorners()
  }
  
  private func roundCorners() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.layer.bounds.height / 2
  }
}
