//
//  SignInViewController.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 18/11/2021.
//

import UIKit
import SVProgressHUD

class SignInViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Properties
    let database = FirebaseDatabase()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        SVProgressHUD.show()
        
        database.signIn(email: usernameTextField.text!, password: passwordTextField.text!, success: { result in
            guard let result = result
            else {
                print("Unexpected error")
                return
            }
            
            print("Signed In user email: \(result.user.email ?? "unknown email")")
            
            SVProgressHUD.dismiss()
            
            self.performSegue(withIdentifier: "openChat", sender: self)
        }, failure: { error in
            print(error)
            
            SVProgressHUD.dismiss()
        })
    }
    
}
