//
//  ChatTableDataSource.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 18/11/2021.
//

import UIKit

class ChatTableDataSource: NSObject, UITableViewDataSource {
    
    var messages = [Message]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        cell.setup(messages[indexPath.row])
        
        return cell
    }
}
