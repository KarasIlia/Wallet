//
//  NetworkService.swift
//  Wallet
//
//  Created by Илья Карась on 18.11.2020.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]

class Connectivity {
  class var isConnectedToInternet: Bool { NetworkReachabilityManager()?.isReachable ?? false }
}

enum ResponseError: String, Error {
  case unableToComplete = "Unable to complete your request. Please check your internet connection"
  case invalidResponse  = "Invalid response from the server. Please try again."
  case invalidData      = "The data received from the server was invalid. Please try again."
}

class NetworkService {
  static let shared = NetworkService()
  
  private init() {}
  
  let domain = "https://wallet.com/"
  let languageCode = Locale.current.languageCode ?? "en"
  var accessToken: String {
    AuthService.getAccessToken() ?? "no token found"
  }
  var headers: HTTPHeaders {
    ["Accept": "application/json",
     "Authorization": "Bearer " + accessToken]
  }
  
  func login(
    email: String,
    password: String,
    completion: @escaping (Result<JSON, ResponseError>) -> Void
  ) {
    DispatchQueue.global(qos: .userInitiated).async {
      let requestUrl = "\(self.domain)api/sessions"
      let userData = ["email": email, "password": password]
      
      AF.request(
        requestUrl,
        method: .post,
        parameters: userData)
        .responseJSON { (response) in
          let result = self.generateResult(afDataResponse: response)
          completion(result)
        }
    }
  }
  
  // User logout
  
  func logout(completion: @escaping (Result<JSON, ResponseError>) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async { [self] in
      let urlString = "\(domain)api/sessions"
      
      AF.request(
        urlString,
        method: .delete,
        headers: headers)
        .responseJSON { (response) in
          let result = self.generateResult(afDataResponse: response)
          completion(result)
        }
    }
  }
  
  // User registration
  
  func register(
    email: String,
    password: String,
    name: String,
    completion: @escaping (Result<JSON, ResponseError>) -> Void
  ) {
    DispatchQueue.global(qos: .userInitiated).async {
      let urlString = "\(self.domain)api/users"
      let registrationData = ["email": email,
                              "password": password,
                              "name": name]
      
      AF.request(
        urlString,
        method: .post,
        parameters: registrationData)
        .responseJSON { (response) in
          let result = self.generateResult(afDataResponse: response)
          completion(result)
        }
    }
  }
  
  // Reset password
  
  func resetPassword(
    email: String,
    completion: @escaping (Result<JSON, ResponseError>) -> Void
  ) {
    DispatchQueue.global(qos: .userInitiated).async {
      let urlString = "\(self.domain)api/user/password/email"
      let resetData = ["email": email]
      
      AF.request(
        urlString,
        method: .post,
        parameters: resetData)
        .responseJSON { (response) in
          let result = self.generateResult(afDataResponse: response)
          completion(result)
        }
    }
  }
  
  // Generate the result of a simple query: Result<JSON, ResponseError> using AFDataResponse<Any> from request response
  
  private func generateResult(afDataResponse: AFDataResponse<Any>) -> Result<JSON, ResponseError> {
    if let _ = afDataResponse.error {
      return .failure(.unableToComplete)
    }
    
    guard let httpResponse = afDataResponse.response, httpResponse.statusCode == 200 else {
      return .failure(.invalidResponse)
    }
    
    guard let value = afDataResponse.value as? JSON, let json = value["data"] as? JSON else {
      return .failure(.invalidData)
    }
    //            let authorizationUserData = UserAuthenticationData(json: json)
    return .success(json)
  }
  
}
