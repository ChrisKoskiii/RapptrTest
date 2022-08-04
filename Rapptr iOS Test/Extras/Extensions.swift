//
//  Extensions.swift
//  Rapptr iOS Test
//
//  Created by Christopher Koski on 8/3/22.
//

import UIKit

extension UITextField {
  
  enum PaddingSide {
    case left(CGFloat)
    case right(CGFloat)
    case both(CGFloat)
  }
  
  func addPadding(_ padding: PaddingSide) {
    
    self.leftViewMode = .always
    self.layer.masksToBounds = true
    
    
    switch padding {
      
    case .left(let spacing):
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
      self.leftView = paddingView
      self.rightViewMode = .always
      
    case .right(let spacing):
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
      self.rightView = paddingView
      self.rightViewMode = .always
      
    case .both(let spacing):
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
      // left
      self.leftView = paddingView
      self.leftViewMode = .always
      // right
      self.rightView = paddingView
      self.rightViewMode = .always
    }
  }
}

extension UIView {
  
  func fadeIn(duration: TimeInterval = 0.75) {
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 1.0
    })
  }
  
  func fadeOut(duration: TimeInterval = 0.75) {
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 0.0
    })
  }
}


extension UIImageView {
  func loadFrom(URLAddress: String) {
    guard let url = URL(string: URLAddress) else {
      return
    }
    
    DispatchQueue.main.async { [weak self] in
      if let imageData = try? Data(contentsOf: url) {
        if let loadedImage = UIImage(data: imageData) {
          self?.image = loadedImage
        }
      }
    }
  }
}

