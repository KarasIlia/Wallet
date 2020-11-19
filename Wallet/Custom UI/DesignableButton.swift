//
//  DesignableButton.swift
//  Wallet
//
//  Created by Илья Карась on 16.11.2020.
//

import UIKit
import QuartzCore

@IBDesignable
class DesignableButton: UIButton {
  
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
  
  var startShadowRadius: CGFloat?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupShadow()
    self.layer.backgroundColor = UIColor.white.cgColor
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupShadow()
    self.layer.backgroundColor = UIColor.white.cgColor
  }
  
  fileprivate func setupShadow() {
    self.shadowColor = .lightGray
    self.shadowOpacity = 1.0
    self.shadowRadius = 3.0
    self.shadowOffset = CGSize(width: 0, height: 1)
  }
  
  private func provideAnimation(animationDuration: TimeInterval, delayTime: TimeInterval, springDamping: CGFloat, springVelocity: CGFloat) {
    startShadowRadius = self.shadowRadius
    UIView.animate(
      withDuration: animationDuration,
      delay: delayTime,
      usingSpringWithDamping: springDamping,
      initialSpringVelocity: springVelocity,
      options: .allowUserInteraction,
      animations: {
        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        self.shadowRadius = 1
      }
    )
  }
  
  private func cancelAnimationEffects() {
    self.transform = CGAffineTransform.identity
    self.shadowRadius = startShadowRadius ?? 5
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    provideAnimation(animationDuration: 0.5, delayTime: 0, springDamping: 5, springVelocity: 6)
    super.touchesBegan(touches, with: event)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    cancelAnimationEffects()
    super.touchesEnded(touches, with: event)
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    cancelAnimationEffects()
    super.touchesCancelled(touches, with: event)
  }
}


