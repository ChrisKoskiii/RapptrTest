//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct Message: Codable {
    let userID: String
    let name: String
    let avatarURL: String
    let message: String
    
    init(testName: String, withTestMessage message: String) {
        self.userID = "1"
        self.name = testName
        self.avatarURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png"
        self.message = message
    }
  
  enum CodingKeys: String, CodingKey {
          case userID = "user_id"
          case name
          case avatarURL = "avatar_url"
          case message
      }
}
