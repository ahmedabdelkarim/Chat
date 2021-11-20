//
//  RegistrationViewController.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 09/11/2021.
//

import UIKit
import SVProgressHUD

class RegistrationViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Properties
    let database = FirebaseDatabase()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @IBAction func registerButtonTapped(_ sender: Any) {
        SVProgressHUD.show()
        
        database.registerUser(email: usernameTextField.text!, password: passwordTextField.text!, success: { result in
            guard let result = result
            else {
                print("Unexpected error")
                return
            }
            
            print("Registered \(result.user.email ?? "unknown email")")
            
            SVProgressHUD.dismiss()
            
            self.performSegue(withIdentifier: "openChat", sender: self)
        }, failure: { error in
            print(error)
            
            SVProgressHUD.dismiss()
        })
    }
}
