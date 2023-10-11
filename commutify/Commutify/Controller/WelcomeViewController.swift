//
//  WelcomeViewController.swift
//  Commutify
//
//  Created by Ricardo Avendaño on 5/16/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {


	@IBOutlet weak var titleLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		/* animation on start */
		
		titleLabel.text = ""
		
		var charIndex = 0.0
		
		let titleText = "Commutify💬"
		
		for i in titleText {
			
		    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
			
			   self.titleLabel.text?.append(i)
		    }
			
		    charIndex += 1
		}

	
		
    }
    

}
