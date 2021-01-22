//
//  GradientedCurvedBackgroundView.swift
//  Wallet
//
//  Created by Илья Карась on 22.11.2020.
//

import UIKit

class GradientedCurvedBackgroundView: UIView {
  
  var gradientLayer: CAGradientLayer = {
    let colorTop = UIColor(red: 35.0 / 255.0, green: 210.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 29.0 / 255.0, green: 96.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.frame = CGRect.zero
    return gradientLayer
  }()
  
  override func draw(_ rect: CGRect) {
    createComplexShape()
    addGradient()
  }
  
  private func createComplexShape() {
    let path = UIBezierPath()
    let height = self.frame.size.height
    let width = self.frame.size.width
    
    path.move(to: CGPoint(x: 0.0, y: 0.0))
    path.addLine(to: CGPoint(x: 0.0, y: height - 50))
    path.addCurve(to: CGPoint(x: width, y: height - 50),
                  controlPoint1: CGPoint(x: 150, y: height - 125),
                  controlPoint2: CGPoint(x: width - 150, y: height + 75))
    path.addLine(to: CGPoint(x: width, y: 0))
    path.addLine(to: CGPoint(x: 0.0, y: 0.0))
    path.close()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    
    self.layer.mask = shapeLayer
  }
  
  private func addGradient() {
    self.layer.addSublayer(gradientLayer)
    gradientLayer.frame = self.bounds
  }
}
