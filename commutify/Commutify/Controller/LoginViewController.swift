//
//  LoginViewController.swift
//  Commutify
//
//  Created by Ricardo Avendaño on 5/16/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController {

	@IBOutlet weak var emailTextfield: UITextField!
	@IBOutlet weak var passwordTextfield: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
	
	@IBAction func loginPressed(_ sender: UIButton) {
	
		ProgressHUD.show()

		Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
			
			if error != nil {
				
				ProgressHUD.showError()
				print(error!)
				
				self.navigationController?.popToRootViewController(animated: true)
				
			} else {
								
				ProgressHUD.dismiss()
				
				self.performSegue(withIdentifier: "goToChat", sender: self)
			}
			
			
		}
		
	
	}
	
	
}
