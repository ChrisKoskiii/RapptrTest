//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
  
  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Setup cell to match mockup
   *
   * 2) Include user's avatar image
   **/
  
  // MARK: - Outlets
  @IBOutlet weak var header: UILabel!
  @IBOutlet weak var body: PaddingLabel!
  @IBOutlet weak var avatar: UIImageView!
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    style()
  }
  
  // MARK: - Public
  func setCellData(message: Message) {
    header.text = message.name
    body.text = message.message
    avatar.loadFrom(URLAddress: message.avatarURL)
    avatar.layer.cornerRadius = avatar.frame.height/2
  }
}

extension ChatTableViewCell {
  private func style() {
    backgroundColor = UIColor.clear

    header.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    
    body.font = UIFont.systemFont(ofSize: 15)
    body.backgroundColor = .white
    body.layer.borderColor = UIColor.lightGray.cgColor
    body.layer.cornerRadius = 8
    body.padding(8.0, 8.0, 8.0, 8.0)


  }
}
