//
//  RegistrationViewController.swift
//  Wallet
//
//  Created by Илья Карась on 18.11.2020.
//

import UIKit

class RegistrationViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tapGestureRecognition()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeObservers()
  }
  
  func register(
    email: String,
    password: String,
    name: String
  ) {
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
    
    DispatchQueue.global(qos: .userInitiated).async {
      NetworkService.shared.register(
        email: email,
        password: password,
        name: name
      ) { [self] (result) in
        switch result {
        case .success(_):
          showAlert(with: "Регистрация завершена успешно", message: "") {
            Router.shared.presentAuthenticationScreen()
          }
        case .failure(let error):
          showAlert(with: "Ошибка", message: error.rawValue)
        }
      }
    }
  }
  
  // MARK: - @IBActions
  
  @IBAction func registerTapped() {
    view.endEditing(true)
    register(
      email: emailTextField.text!,
      password: passwordTextField.text!,
      name: nameTextField.text!
    )
  }
  
  @IBAction func toLoginTapped(_ sender: UIButton) {
    self.dismiss(animated: true)
//    Router.shared.presentAuthenticationScreen()
  }
}

extension RegistrationViewController: UITextFieldDelegate {
  
  func textFieldsDelegateSetup() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
    nameTextField.delegate = self
  }
  
  func tapGestureRecognition() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTouchGestureHandler))
    tapGesture.numberOfTapsRequired = 1
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func singleTouchGestureHandler(recognizer: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case emailTextField:
      passwordTextField.becomeFirstResponder()
    case passwordTextField:
      registerTapped()
    case nameTextField:
      emailTextField.becomeFirstResponder()
    default:
      break
    }
    return true
  }
  
  func addObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func removeObservers() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc
  func keyboardWillShow(notification: NSNotification) {
    guard
      let userInfo = notification.userInfo,
      let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      else {
        return
    }
    
    let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
    scrollView.contentInset = contentInset
  }
  
  @objc
  func keyboardWillHide(notification: NSNotification) {
    scrollView.contentInset = UIEdgeInsets.zero
  }
}
