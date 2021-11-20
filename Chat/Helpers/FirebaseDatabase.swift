//
//  FirebaseDatabase.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 18/11/2021.
//

import Foundation
import Firebase

class FirebaseDatabase {
    let database: DatabaseReference
    
    init() {
        database =  Database.database().reference()
    }
    
    static var currentUser: User? {
        get {
            return Auth.auth().currentUser
        }
    }
    
    func registerUser(email: String, password: String, success: @escaping (AuthDataResult?)->Void, failure: @escaping (Error)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                failure(error)
            }
            else {
                success(result)
            }
        }
    }
    
    func signIn(email: String, password: String, success: @escaping (AuthDataResult?)->Void, failure: @escaping (Error)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                failure(error)
            }
            else {
                success(result)
            }
        }
    }
    
    func sendMessage(message: Message, success: @escaping ()->Void, failure: @escaping (Error)->Void) {
        let messages = database.child("Messages")
        let userEmail = FirebaseDatabase.currentUser?.email
        
        let messageDictionary = ["sender":userEmail, "messageText":message.messageText]
        
        messages.childByAutoId().setValue(messageDictionary) { error, reference in
            if let error = error {
                failure(error)
            }
            else {
                success()
            }
        }
    }
    
    func listenToMessages(childAdded: @escaping (Message)->Void) {
        let messages = database.child("Messages")
        
        messages.observe(.childAdded) { (snapshot) in
            let messageDictionary = snapshot.value as! Dictionary<String,String>
            
            let sender = messageDictionary["sender"]!
            let messageText = messageDictionary["messageText"]!
            
            print(sender, messageText)
            
            let message = Message(sender: sender, messageText: messageText)
            
            childAdded(message)
        }
    }
}
