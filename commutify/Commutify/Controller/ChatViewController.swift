//
//  ChatViewController.swift
//  Commutify
//
//  Created by Ricardo Avendaño on 5/16/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
	
	var messageArray : [Message] = [Message]()
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var messageTextfield: UITextField!
	
	@IBOutlet weak var sendButton: UIButton!
	@IBOutlet weak var heightConstraint: NSLayoutConstraint!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		navigationItem.hidesBackButton = true
		overrideUserInterfaceStyle = .light
		   
		messageTextfield.delegate = self
		
		sendButton.isEnabled = false
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
		
		tableView.addGestureRecognizer(tapGesture)
		   
		tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
		   
		configureTableView()
		
		retrieveMessages()
		
		tableView.separatorStyle = .none
		
		
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
		    
		cell.messageBody.text = messageArray[indexPath.row].messageBody
		cell.senderUsername.text = messageArray[indexPath.row].sender
		
		if cell.senderUsername.text == Auth.auth().currentUser?.email as String? {
			
			cell.avatarImageView.image = UIImage(named: "capybara")
			//cell.messageBackground.backgroundColor = UIColor.flatMint()
			
		} else {
			
			cell.avatarImageView.image = UIImage(named: "guinea-pig")
			//cell.messageBackground.backgroundColor = UIColor.black
			
		}
		    
		    return cell

	}
	
	
	@objc func tableViewTapped() {
		
		messageTextfield.endEditing(true)
		
	}
	
	func configureTableView() {

		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 120.0

	}
	
	/* */
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		 
		 UIView.animate(withDuration: 0.25, animations: {
			
			 self.heightConstraint.constant = 308
			 self.view.layoutIfNeeded()
			
		 })
		
		
	 }

	 func textFieldDidEndEditing(_ textField: UITextField) {
		
		 UIView.animate(withDuration: 0.25, animations: {
			
			 self.heightConstraint.constant = 50
			 self.view.layoutIfNeeded()
			
		 })
		
		
	 }
	
	/* */
	
	/* */
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		let text = (messageTextfield.text! as NSString).replacingCharacters(in: range, with: string)
		
		if text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
		
			sendButton.isEnabled = false
		
		} else {
			
			sendButton.isEnabled = true
		
		}
		
		
	return true
	}
	
	/* */
	
	@IBAction func sendPressed(_ sender: UIButton) {
			
			messageTextfield.endEditing(true)
			messageTextfield.isEnabled = false
			sendButton.isEnabled = false
			
			let messageDB = Database.database().reference().child("Messages")
			
			let messageBody = messageTextfield.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		
			let messageDictionary = [
								"Sender" : Auth.auth().currentUser?.email,
								//"MessageBody" : messageTextfield.text!
								"MessageBody" : messageBody
								]
			
			messageDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
				
				if error != nil {
					
					print(error!)
					
				} else {
					
					print("success")
					
					self.messageTextfield.isEnabled = true
					self.messageTextfield.text = ""
				}
				
				
			}
		
		
	}
	
	func retrieveMessages() {
		
		let messageDB = Database.database().reference().child("Messages")
		
		messageDB.observe(.childAdded) { (snapshot) in
			
			let snapshotValue = snapshot.value as! Dictionary<String,String>
			
			let text = snapshotValue["MessageBody"]!
			let sender = snapshotValue["Sender"]!
			
			let message = Message()
			message.messageBody = text
			message.sender = sender
			
			self.messageArray.append(message)
			
			//self.configureTableView()
			self.tableView.reloadData()
		
		}
		
		
	}
	
	@IBAction func logOutPressed(_ sender: Any) {
	
		do {
			
			try Auth.auth().signOut()
			
			navigationController?.popToRootViewController(animated: true)
			
		} catch {
		
			print("Error")
			
		}
		
		
	}
	
	
}
