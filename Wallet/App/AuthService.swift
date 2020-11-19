//
//  AuthService.swift
//  Wallet
//
//  Created by Илья Карась on 18.11.2020.
//

import Foundation
import Keychain

struct AuthService {
  
  // Get access token from keychain
  static func getAccessToken() -> String? {
    return Keychain.load("access_token")
  }
  
  // Save access token in keychain
  static func setAccessToken(accessToken: String) -> Bool {
    return Keychain.save(accessToken, forKey: "access_token")
  }
  
  // Remove access token from keychain
  static func deleteAccessToken() -> Bool {
    if Keychain.delete("access_token") {
      print("access token removed")
      return true
    }
    print("access token remove failure")
    return false
  }
}
