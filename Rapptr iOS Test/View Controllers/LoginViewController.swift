//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
  
  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Make the UI look like it does in the mock-up.
   *
   * 2) Take email and password input from the user
   *
   * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
   *
   * 4) Calculate how long the API call took in milliseconds
   *
   * 5) If the response is an error display the error in a UIAlertController
   *
   * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
   *
   * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
   **/
  
  let stackView = UIStackView()
  let usernameTextField = UITextField()
  let passwordTextField = UITextField()
  let loginButton = UIButton(configuration: .filled())
  
  // MARK: - Properties
  var loginClient = LoginClient()
  var delegate: LoginClientDelegate?
  
  var reponseMessage: String = ""
  var requestDuration: Int = 0
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Login"
    
    loginClient.delegate = self
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    backgroundImage.image = UIImage(named: "img_login")
    backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
    self.view.insertSubview(backgroundImage, at: 0)
    
    style()
    layout()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Actions
  
  @objc private func loginTapped() {
    didLogIn()
  }
}

// MARK: Style & Layout
extension LoginViewController {
  
  private func style() {
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 24
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.placeholder = "Username"
    usernameTextField.delegate = self
    usernameTextField.addPadding(.left(24))
    usernameTextField.backgroundColor = .white.withAlphaComponent(0.9)
    usernameTextField.layer.cornerRadius = 4
    
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    passwordTextField.delegate = self
    passwordTextField.addPadding(.left(24))
    passwordTextField.backgroundColor = .white.withAlphaComponent(0.9)
    passwordTextField.layer.cornerRadius = 4
    
    var container = AttributeContainer()
    container.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    container.foregroundColor = UIColor.white
    
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.configuration = .filled()
    loginButton.configuration?.baseBackgroundColor = UIColor(named: "NavBarColor")
    loginButton.configuration?.attributedTitle = AttributedString("LOGIN", attributes: container)
    loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
  }
  
  private func layout() {
    stackView.addArrangedSubview(usernameTextField)
    stackView.addArrangedSubview(passwordTextField)
    stackView.addArrangedSubview(loginButton)
    
    view.addSubview(stackView)
    
    //stackView
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 8),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3.75),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3.75)
    ])
    
    
    usernameTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
    passwordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
  }
}

// MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    usernameTextField.endEditing(true)
    passwordTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    
  }
}

// MARK: LoginClientDelegate
extension LoginViewController: LoginClientDelegate {
  func didLogIn() {
    loginClient.login(email: "info@rapptrlabs.com", password: "Test123") { response in
      self.showSuccessAlert(message: response, duration: self.loginClient.elapsedTime)
    } error: { error in
      print("Error logging in, \(String(describing: error))")
    }
  }
}

// MARK: Alerts
extension LoginViewController {
  func showSuccessAlert(message: String, duration: Int) {
    let myMessage = message+" This took \(duration) milliseconds"
    let alert = UIAlertController(title: "API Attempt", message: myMessage, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: { _ in
    }))
    self.present(alert, animated: true, completion: nil)
    print("Showed alert")
  }
}
