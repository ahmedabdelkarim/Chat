//
//  ChatViewController.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 18/11/2021.
//

import UIKit
import SVProgressHUD

class ChatViewController: UIViewController, UITableViewDelegate {
    //MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var dataSource = ChatTableDataSource()
    let database = FirebaseDatabase()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTable.dataSource = dataSource
        chatTable.delegate = self
        
        chatTable.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        messageTextField.delegate = self
        
        listenToMessages()
    }
    
    //MARK: - Methods
    func listenToMessages() {
        database.listenToMessages {  message in
            self.dataSource.messages.append(message)
            
            self.chatTable.reloadData() // it reloads too much in  first load
        }
    }
    
    //MARK: - Actions
    @IBAction func sendButtonTapped(_ sender: Any) {
        sendButton.isEnabled = false
        messageTextField.isEnabled = false
        
        SVProgressHUD.show()
        
        let message = Message(sender: "", messageText: messageTextField.text!)
        database.sendMessage(message: message, success: {
            print("Message Saved ")
            
            self.messageTextField.text = ""
            self.sendButton.isEnabled = true
            self.messageTextField.isEnabled = true
            
            SVProgressHUD.dismiss()
        }, failure: { error in
            print(error)
            
            self.sendButton.isEnabled = true
            self.messageTextField.isEnabled = true
            
            SVProgressHUD.dismiss()
        })
    }
    
    @IBAction func tableTapped(_ sender: Any) {
        messageTextField.endEditing(true)
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomConstraint.constant = 324
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomConstraint.constant = 12
            self.view.layoutIfNeeded()
        })
    }
}
