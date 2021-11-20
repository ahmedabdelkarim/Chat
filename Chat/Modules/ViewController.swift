//
//  ViewController.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 08/11/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(Configuration.environment)
        
        #if Dev
        print("dev")
        #elseif Prod
        print("Prod")
        #endif
        
        
    }


}

