//
//  ViewController.swift
//  Magic D20
//
//  Created by Ricardo Avendaño on 5/17/19.
//  Copyright © 2019 Ricardo Avendaño. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var randomD20 : Int = 0
    
     let diceArray = ["d20-1", "d20-2", "d20-3", "d20-4", "d20-5", "d20-6", "d20-7", "d20-8", "d20-9", "d20-10"]
    
    
     @IBOutlet weak var d20: UIImageView!
   
     override func viewDidLoad() {
          super.viewDidLoad()
        
          randomizeDice()
          // Do any additional setup after loading the view, typically from a nib.
     }
     
     @IBAction func rollButtonPressed(_ sender: UIButton) {
          randomizeDice()
     }
    
     func randomizeDice(){
          randomD20 = Int(arc4random_uniform(10))
        
          d20.image = UIImage(named: diceArray[randomD20])
     }
    
     override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
          randomizeDice()
    }
    
}

