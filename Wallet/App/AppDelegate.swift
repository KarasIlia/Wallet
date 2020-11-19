//
//  AppDelegate.swift
//  Wallet
//
//  Created by Илья Карась on 16.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  static var instance: AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Initialize window
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    // Check if it's first launch
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    if !launchedBefore {
      _ = AuthService.deleteAccessToken()
      UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    // Check if user availability
    if AuthService.getAccessToken() != nil {
      Router.shared.presentMainScreen()
    } else {
      Router.shared.presentAuthenticationScreen()
    }
    
    return true
  }
}

