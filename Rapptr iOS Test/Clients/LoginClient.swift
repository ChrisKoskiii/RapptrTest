//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation
import Alamofire
/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
 */

protocol LoginClientDelegate {
  func didLogIn()
}
class LoginClient {
  
  var delegate: LoginClientDelegate?
  var elapsedTime: Int = 0
  
  func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {
    let myURL: URL = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")!
    let alamoURL: Alamofire.URLConvertible = myURL
    
    let params = [
      "email": email,
      "password": password
    ]
    
    let start = Date.timeIntervalSinceReferenceDate
    
    AF.request(alamoURL, method: .post, parameters: params).responseJSON { response in
      switch response.result {
      case.success(_):
        //calculate elapsed time
        let end = Date.timeIntervalSinceReferenceDate
        self.elapsedTime = Int((end - start) * 1000)
        
        let responseJSON = try? JSONSerialization.jsonObject(with: response.data!, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
          completion(responseJSON["message"] as! String)
        }
        
      case.failure(let error):
        print("Error, \(error)")
      }  
    }
  }
}
