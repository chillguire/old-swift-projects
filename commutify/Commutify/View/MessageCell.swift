//
//  MessageCell.swift
//  Commutify
//
//  Created by Ricardo Avendaño on 5/17/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
	
	@IBOutlet var messageBackground: UIView!
	@IBOutlet var avatarImageView: UIImageView!
	@IBOutlet var messageBody: UILabel!
	@IBOutlet var senderUsername: UILabel!
	
	override func awakeFromNib() {
	    super.awakeFromNib()
	    // Initialization code goes here
	    
	    
	    
	}
	
	
}
