//
//  Router.swift
//  Wallet
//
//  Created by Илья Карась on 18.11.2020.
//

import UIKit

class Router {
  
  static let shared = Router()
  private init() {}
  
  func presentMainScreen() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
    AppDelegate.instance?.window?.rootViewController = viewController
  }
  
  func presentAuthenticationScreen() {
    let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
    let viewController = storyBoard.instantiateViewController(withIdentifier: "AuthenticationViewController") as! AuthenticationViewController
    AppDelegate.instance?.window?.rootViewController = viewController
  }
}
