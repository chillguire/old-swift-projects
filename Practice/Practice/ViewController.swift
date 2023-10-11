//
//  ViewController.swift
//  Practice
//
//  Created by Ricardo Avendaño on 4/28/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CanRecieve {

	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var label: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBAction func buttonPressed(_ sender: UIButton) {
		performSegue(withIdentifier: "sendDataForwards", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "sendDataForwards" {
			let destinationVC = segue.destination as! SecondViewController // this is going to be an object from second view controller
			destinationVC.dataFromVC = textField.text!
			
			destinationVC.delegate = self
			
		}
	}
	
	func dataRecieved(dataFromVC: String) {
		label.text = dataFromVC
	}
	
}

