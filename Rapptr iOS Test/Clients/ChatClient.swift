//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */


protocol ChatClientDelegate {
  func didUpdateChatData(_ chatClient: ChatClient)
}
struct ChatClient {
  
  var delegate: ChatClientDelegate?
  
  func fetchChatData(completion: @escaping (Messages) -> Void, error errorHandler: @escaping (String?) -> Void) {
    let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        return
      }
      if let data = data,
        let chatData = try? JSONDecoder().decode(Messages.self, from: data) {
        completion(chatData)
        print(data)
        print("Success")
      }
    })
    task.resume()
  }
}
