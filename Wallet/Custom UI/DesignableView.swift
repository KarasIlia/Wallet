//
//  DesignableView.swift
//  Wallet
//
//  Created by Илья Карась on 16.11.2020.
//

import UIKit
import QuartzCore

@IBDesignable
class DesignableView: UIView {

  @IBInspectable
  var cornerRadius: CGFloat = 0.0 {
    didSet { self.layer.cornerRadius = cornerRadius }
  }
  
  @IBInspectable
  var borderWidth: CGFloat = 0 {
    didSet { self.layer.borderWidth = borderWidth }
  }
  
  @IBInspectable
  var borderColor: UIColor = .clear {
    didSet { self.layer.borderColor = borderColor.cgColor }
  }
  
  @IBInspectable
  var shadowColor: UIColor = .lightGray {
    didSet { self.layer.shadowColor = shadowColor.cgColor }
  }
  
  @IBInspectable
  var shadowOpacity: Float = 1.0 {
    didSet { self.layer.shadowOpacity = shadowOpacity }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat = 3.0 {
    didSet { self.layer.shadowRadius = shadowRadius }
  }
  
  @IBInspectable
  var shadowOffset: CGSize = CGSize(width: 0, height: 1) {
    didSet { self.layer.shadowOffset = shadowOffset }
  }
}
