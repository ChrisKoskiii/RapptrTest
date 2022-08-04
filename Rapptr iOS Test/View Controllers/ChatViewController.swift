//
//  ChatViewController.swift
//  iOSTest
//

//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Make the UI look like it does in the mock-up.
   *
   * 2) Using the following endpoint, fetch chat data
   *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
   *
   * 3) Parse the chat data using 'Message' model
   *
   **/
  
  // MARK: - Properties
  private var messages: [Message]?
  
  
  let myTableView = UITableView()
  
  var chatClient = ChatClient()
  
  var delegate: ChatClientDelegate?
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messages = [Message]()
    configureTable(tableView: myTableView)
    title = "Chat"
    chatClient.delegate = self
    
    
    self.chatClient.fetchChatData { [self] chatData in
      self.messages = chatData.data
      DispatchQueue.main.async {
        self.myTableView.reloadData()
      }
    } error: { error in
      print("Error fetching chat, \(String(describing: error))")
    }
    
    style()
    layout()
  }
  
  //workaround from depricated way to get height using statusBarFrame.height
  override func viewDidLayoutSubviews() {
    let barHeight: CGFloat = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
    let displayWidth: CGFloat = self.view.frame.width
    let displayHeight: CGFloat = self.view.frame.height
    
    myTableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
  }
  
  // MARK: - Private
  private func configureTable(tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 58
    tableView.backgroundColor = UIColor(named: "ViewBackground")
  }
  
  // MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: ChatTableViewCell? = nil
    if cell == nil {
      let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
      cell = nibs?[0] as? ChatTableViewCell
    }
    cell?.setCellData(message: messages![indexPath.row])
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages!.count
  }
  
  // MARK: - UITableViewDelegate
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableView.automaticDimension
//  }
//  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 58
//  }
  
  // MARK: - IBAction
  @objc func backAction(_ sender: Any) {
    let mainMenuViewController = MenuViewController()
    self.navigationController?.pushViewController(mainMenuViewController, animated: true)
  }
}

// MARK: Style
extension ChatViewController {
  private func style() {
    
    myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    myTableView.dataSource = self
    myTableView.delegate = self
    self.view.addSubview(myTableView)
  }
  
  private func layout() {
    
  }
}

//MARK: ChatClientDelegate
extension ChatViewController: ChatClientDelegate {
  func didUpdateChatData(_ chatClient: ChatClient) {
    DispatchQueue.main.async {
      chatClient.fetchChatData() { chatData in
        self.messages = chatData.data
        self.myTableView.reloadData()
      } error: { error in
        print("Error fetching chat, \(String(describing: error))")
      }
    }
  }
}
