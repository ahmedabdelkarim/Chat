//
//  MessageCell.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 18/11/2021.
//

import UIKit

class MessageCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Methods
    func setup(_ message: Message) {
        profileImage.image = UIImage(systemName: "person.circle")
        
        userName.text = message.sender
        messageLabel.text = message.messageText
        
        if let currentUser = FirebaseDatabase.currentUser, currentUser.email == message.sender {
            profileImage.backgroundColor = UIColor(named: "Message-Background-Mine")
            messageBackground.backgroundColor = UIColor(named: "Message-Background-Mine")
            userName.textColor = .white
            messageLabel.textColor = .white
        }
        else {
            profileImage.backgroundColor =  UIColor(named: "Message-Background-Others")
            messageBackground.backgroundColor = UIColor(named: "Message-Background-Others")
            userName.textColor = .black
            messageLabel.textColor = .black
        }
    }
}
