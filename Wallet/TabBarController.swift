//
//  TabBarController.swift
//  Wallet
//
//  Created by Илья Карась on 16.11.2020.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    disableEmptyTabBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
//    self.view.bringSubviewToFront(self.tabBar)
//    self.addCenterButton()
  }
  
//  private func addCenterButton() {
//    let button = UIButton(type: .custom)
//    let square = self.tabBar.frame.size.height + 20
//    button.frame = CGRect(x: 0, y: 0, width: square, height: square)
//    button.layer.cornerRadius = square / 2
//    button.center = CGPoint(x: self.tabBar.center.x, y: self.tabBar.center.y - 40)
//    button.backgroundColor = UIColor.systemBlue
//    button.tintColor = .white
//    button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
//
//    self.view.addSubview(button)
//    self.view.bringSubviewToFront(button)
//
//    button.addTarget(self, action: #selector(didTouchCenterButton(_:)), for: .touchUpInside)
//  }
  
  private func disableEmptyTabBar() {
    if
      let arrayOfTabBarItems = self.tabBar.items as AnyObject as? NSArray,
      let tabBarItem = arrayOfTabBarItems[2] as? UITabBarItem
    {
      tabBarItem.isEnabled = false
    }
  }
  
  @objc
  private func didTouchCenterButton(_ sender: AnyObject) {
    print("Center button tapped")
  }
  
}
