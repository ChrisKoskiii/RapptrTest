//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
  
  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Make the UI look like it does in the mock-up.
   *
   * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
   *
   * 3) User should be able to drag the logo around the screen with his/her fingers
   *
   * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
   *    section in Swfit to show off your skills. Anything your heart desires!
   *
   */
  
  let logoImage = UIImageView()
  let fadeButton = UIButton()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Animation"
    view.backgroundColor = .white
    style()
    layout()
  }
}

extension AnimationViewController {
  private func style() {
    
    logoImage.translatesAutoresizingMaskIntoConstraints = false
    logoImage.image = UIImage(named: "ic_logo")
    logoImage.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    fadeButton.translatesAutoresizingMaskIntoConstraints = false
    fadeButton.backgroundColor = UIColor(named: "NavBarColor")
    fadeButton.setTitle("FADE OUT", for: .normal)
    fadeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    fadeButton.addTarget(self, action: #selector(didPressFade), for: .touchUpInside)
    
  }
  
  private func layout() {
    view.addSubview(logoImage)
    view.addSubview(fadeButton)
    
    NSLayoutConstraint.activate([
      logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImage.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 25)
    ])
    
    NSLayoutConstraint.activate([
      fadeButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
      fadeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3.75),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: fadeButton.trailingAnchor, multiplier: 3.75),
      view.bottomAnchor.constraint(equalToSystemSpacingBelow: fadeButton.bottomAnchor, multiplier: 10),
      fadeButton.heightAnchor.constraint(equalToConstant: 55)
    ])
  }
}


// MARK: - Actions
extension AnimationViewController {
  @objc func backAction(_ sender: Any) {
    let mainMenuViewController = MenuViewController()
    self.navigationController?.pushViewController(mainMenuViewController, animated: true)
  }
  
  @objc func didPressFade(_ sender: Any) {
    if logoImage.alpha == 0 {
      logoImage.fadeIn()
      fadeButton.setTitle("FADE OUT", for: .normal)
    } else {
      fadeButton.setTitle("FADE IN", for: .normal)
      logoImage.fadeOut()
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    var location = CGPoint(x: 0, y: 0)
    let touch: UITouch = touches.first! as UITouch
    location = touch.location(in: self.view)
    logoImage.center = location
    
  }
  
}
