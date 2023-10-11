//
//  ViewController.swift
//  Adventure
//
//  Created by Ricardo Avendaño on 6/15/19.
//  Copyright © 2019 Ricardo Avendaño. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Historias y respectivas dos respuestas
	
    let allSituations = SituationBank()
    
    // Elementos de UI linkeados al storyboard
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var storyText: UILabel!
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    var storyIndex = 1 // storyIndex define la escena donde se encuentra la historia (e.g storyIndex = 1 es el inicio, mientras que storyIndex = 2 y storyIndex = 3 son sus dos repuestas)
    let backgrounds = ["background", "background2", "background3", "background4"]    
	
	// Funciones y flujo principal de la app
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
        restartGame()

    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        // sender.tag = 0 es el botón de arriba, sender.tag = 1 es el botón de abajo y sender.tag = 2 es el botón de restart.
	
        // storyIndex == 1
        if sender.tag == 0 && storyIndex == 1 {
            storyText.text = allSituations.list[1].situationText
            aButton.setTitle(allSituations.list[1].answerA, for: .normal)
		  bButton.setTitle(allSituations.list[1].answerB, for: .normal)
            storyIndex = 2
            background.image = UIImage(named: backgrounds[0])
        }else if sender.tag == 1 && storyIndex == 1{
            storyText.text = allSituations.list[2].situationText
            aButton.setTitle(allSituations.list[2].answerA, for: .normal)
            bButton.setTitle(allSituations.list[2].answerB, for: .normal)
            storyIndex = 3
            background.image = UIImage(named: backgrounds[1])
        }
        // storyIndex == 2 (Y opción 1 de storyIndex == 4)
	    else if sender.tag == 0 && (storyIndex == 2 || storyIndex == 4) {
            storyText.text = allSituations.list[2].situationText
            aButton.setTitle(allSituations.list[2].answerA, for: .normal)
            bButton.setTitle(allSituations.list[2].answerB, for: .normal)
            storyIndex = 3
            background.image = UIImage(named: backgrounds[1])
        }else if sender.tag == 1 && storyIndex == 2 {
            storyText.text = allSituations.list[3].situationText
            aButton.setTitle(allSituations.list[3].answerA, for: .normal)
            bButton.setTitle(allSituations.list[3].answerB, for: .normal)
            storyIndex = 4
            background.image = UIImage(named: backgrounds[0])
        }
        // storyIndex == 3 (y opción 1 de storyIndex == 6)
	    else if sender.tag == 0 && (storyIndex == 3 || storyIndex == 6) {
            storyText.text = allSituations.list[4].situationText
            aButton.setTitle(allSituations.list[4].answerA, for: .normal)
            bButton.setTitle(allSituations.list[4].answerB, for: .normal)
            storyIndex = 5
            background.image = UIImage(named: backgrounds[2])
        }else if sender.tag == 1 && storyIndex == 3 {
            storyText.text = allSituations.list[5].situationText
            aButton.setTitle(allSituations.list[5].answerA, for: .normal)
            bButton.setTitle(allSituations.list[5].answerB, for: .normal)
            storyIndex = 6
            background.image = UIImage(named: backgrounds[2])
        }
        // storyIndex == 4
	    else if sender.tag == 1 && storyIndex == 4 {
            storyText.text = allSituations.list[8].situationText
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 9
            background.image = UIImage(named: backgrounds[3])
        }
        // storyIndex == 5
	    else if sender.tag == 0 && storyIndex == 5 {
            storyText.text = allSituations.list[6].situationText
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 7
            background.image = UIImage(named: backgrounds[3])
        }else if sender.tag == 1 && storyIndex == 5 {
            storyText.text = allSituations.list[7].situationText
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 8
            background.image = UIImage(named: backgrounds[3])
        }
        // storyIndex == 6
	    else if sender.tag == 1 && storyIndex == 6 {
            storyText.text = allSituations.list[6].situationText
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 7
            background.image = UIImage(named: backgrounds[3])
        }
        
        // Endings
	    if storyIndex == 7 || storyIndex == 8 || storyIndex == 9 {
            restart.isHidden = false
        }
    }
	
	
    @IBAction func restartPressed(_sender: UIButton) {
		let alert = UIAlertController(title: "Alert", message: "You've finished all the questions. Tap restart to start over.", preferredStyle: .alert)
	   
		let alertAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
		   self.restartGame()
	   }
	   
		alert.addAction(alertAction)
	   
		present(alert, animated: true, completion: nil)
    }
    
	
    func restartGame() {
        storyIndex = 1
	   storyText.text = allSituations.list[0].situationText
        aButton.isHidden = false
        bButton.isHidden = false
	   aButton.setTitle(allSituations.list[0].answerA, for: .normal)
        bButton.setTitle(allSituations.list[0].answerB, for: .normal)
        restart.isHidden = true
        background.image = UIImage(named: backgrounds[0])
    }
}

