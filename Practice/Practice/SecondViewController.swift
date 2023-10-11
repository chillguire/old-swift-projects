//
//  SecondViewController.swift
//  Practice
//
//  Created by Ricardo Avendaño on 4/28/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit

protocol CanRecieve {
	func dataRecieved(dataFromVC: String)
}

class SecondViewController: UIViewController {

	var delegate : CanRecieve?
	
	var dataFromVC = ""
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var label: UILabel!
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		label.text = dataFromVC
    }
    
	@IBAction func sendDataBack(_ sender: Any) {
		// performSegue(withIdentifier: "sendDataForwards", sender: self)
		
		delegate?.dataRecieved(dataFromVC: textField.text!)
		dismiss(animated: true, completion: nil)
	}
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
