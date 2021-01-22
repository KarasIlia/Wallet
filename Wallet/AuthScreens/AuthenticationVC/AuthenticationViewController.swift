//
//  AuthenticationViewController.swift
//  Wallet
//
//  Created by Илья Карась on 18.11.2020.
//

import UIKit

class AuthenticationViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var joinButton: UIButton!
  @IBOutlet weak var gradientView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tapGestureRecognition()
    setupUI()
    //    setupShowPasswordButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //    addObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeObservers()
  }
    
  private func setupUI() {
    joinButton.layer.cornerRadius = joinButton.layer.bounds.size.height / 2
  }
  
  private func setupShowPasswordButton() {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
    button.tintColor = .lightGray
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    button.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(20), height: CGFloat(20))
    button.addTarget(self, action: #selector(togglePasswordShow), for: .touchUpInside)
    passwordTextField.rightView = button
    passwordTextField.rightViewMode = .always
  }
  
  private func login(email: String?, password: String?) {
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
    
    DispatchQueue.global(qos: .userInitiated).async {
      NetworkService.shared.login(
        email: email!,
        password: password!
      ) { [self] (result) in
        switch result {
        case .success(_):
          Router.shared.presentMainScreen()
        case .failure(let error):
          showAlert(with: "Ошибка", message: error.rawValue)
        }
      }
    }
  }
  
  @objc
  func togglePasswordShow() {
    passwordTextField.isSecureTextEntry.toggle()
  }
  
  @IBAction func textFieldEditingDidChange(_ sender: UITextField) {
    //    print("textFieldDidChangeSelection")
    //    do {
    //      let validationType: ValidatorType = sender == emailTextField ? .email : .password
    //      _ = try sender.validatedText(validationType: validationType)
    //      sender.layer.borderColor = UIColor.lightGray.cgColor
    //      sender.layer.borderWidth = 1.0
    //      sender.layer.cornerRadius = 5
    //    } catch /*(let error)*/ {
    //      sender.layer.borderColor = UIColor.red.cgColor
    //      sender.layer.borderWidth = 1.0
    //      sender.layer.cornerRadius = 5
    //      //          showAlert(with: nil, message: (error as! ValidationError).message)
    //    }
  }
  
  @IBAction func signInTapped() {
    view.endEditing(true)
//    login(email: emailTextField.text!, password: passwordTextField.text!)
    Router.shared.presentMainScreen()
  }
}

// MARK: - UITextFieldDelegate + Keyboard show handling

extension AuthenticationViewController: UITextFieldDelegate {
  
  func textFieldsDelegateSetup() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
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
      signInTapped()
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

