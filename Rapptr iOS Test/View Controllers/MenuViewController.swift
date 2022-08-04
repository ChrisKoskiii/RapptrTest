//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
  
  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   *
   * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
   *
   * 2) Use Autolayout to make sure all UI works for each resolution
   *
   * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
   *    provided code if necessary. It is ok to add any classes. This is your project now!
   *
   * 4) Read the additional instructions comments throughout the codebase, they will guide you.
   *
   * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
   *
   * Thank you and Good luck. - Rapptr Labs
   * =========================================================================================
   */
  
  let stackView = UIStackView()
  
  let chatButton = UIButton()
  let loginButton = UIButton()
  let animationButton = UIButton()
  
  // MARK: - Outlets
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Coding Tasks"
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    backgroundImage.image = UIImage(named: "bg_home_menu")
    backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
    self.view.insertSubview(backgroundImage, at: 0)
    
    
    style()
    layout()
  }
}

extension MenuViewController {
  private func style() {

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 24
    
    var container = AttributeContainer()
    container.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    container.foregroundColor = UIColor.black
    
    chatButton.translatesAutoresizingMaskIntoConstraints = false
    chatButton.configuration = .borderless()
    chatButton.backgroundColor = .white.withAlphaComponent(0.9)
    chatButton.configuration?.attributedTitle = AttributedString("CHAT", attributes: container)
    chatButton.setTitleColor(UIColor.black, for: [])
    chatButton.setImage(UIImage(named: "ic_chat"), for: [])
    chatButton.configuration?.imagePadding = 16
    chatButton.contentHorizontalAlignment = .left
    chatButton.layer.cornerRadius = 8
    chatButton.addTarget(self, action: #selector(didPressChatButton), for: .touchUpInside)
    
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.configuration = .borderless()
    loginButton.backgroundColor = .white.withAlphaComponent(0.9)
    loginButton.configuration?.attributedTitle = AttributedString("LOGIN", attributes: container)
    loginButton.setImage(UIImage(named: "ic_login"), for: [])
    loginButton.configuration?.imagePadding = 16
    loginButton.contentHorizontalAlignment = .left
    loginButton.layer.cornerRadius = 8
    loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
    
    animationButton.translatesAutoresizingMaskIntoConstraints = false
    animationButton.configuration = .borderless()
    animationButton.backgroundColor = .white.withAlphaComponent(0.9)
    animationButton.configuration?.attributedTitle = AttributedString("ANIMATION", attributes: container)
    animationButton.setImage(UIImage(named: "ic_animation"), for: [])
    animationButton.configuration?.imagePadding = 16
    animationButton.contentHorizontalAlignment = .left
    animationButton.layer.cornerRadius = 8
    animationButton.addTarget(self, action: #selector(didPressAnimationButton), for: .touchUpInside)
  }
  
  private func layout() {
    stackView.addArrangedSubview(chatButton)
    stackView.addArrangedSubview(loginButton)
    stackView.addArrangedSubview(animationButton)
    
    //    view.addSubview(navigationBarView)
    view.addSubview(stackView)

    //stackView
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3.75),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3.75)
    ])
    
    chatButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    animationButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
  }
}

//// MARK: - Actions
extension MenuViewController {
  @objc func didPressChatButton() {
    let chatViewController = ChatViewController()
    self.navigationController?.pushViewController(chatViewController, animated: true)
  }

  @objc func didPressLoginButton(_ sender: Any) {
    let loginViewController = LoginViewController()
    self.navigationController?.pushViewController(loginViewController, animated: true)
  }

  @objc func didPressAnimationButton(_ sender: Any) {
    let animationViewController = AnimationViewController()
    self.navigationController?.pushViewController(animationViewController, animated: true)
  }
}
