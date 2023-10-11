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
	
    let story1 = "You just woke up in a place you can’t recognize after going to celebrate that you were able to leave Venezuela, and you’re currently feeling a really bad headache that doesn’t let you remember anything about the reason you could be in here. As you look around for your phone without success, you see a TV turned on with the local news in it."
	
    let answer1a = "Maybe the news will help me figure out where I am."
    let answer1b = "Maybe I got drunk and I’m still feeling sick, I’ll look around to see if I remember anything."
    
    
    let story2 = "You get close to the TV in order to gather useful information about the place you’re in. Unfortunately, you see that the TV has no sound, and you’re unable to read the words that appear on TV since you never learned how to read. However, you see the US flag hanging above the TV, and besides there’s a confederate flag, the flag of a group known because of their tendencies towards racism practices against people of color."
	
    let answer2a = "Well, it’ll be better if I explore this place carefully."
    let answer2b = "I can't explore this place in this state. I’ll better stay resting here and hide if something happens."
    

    let story3 = "You start walking around the house and note that it’s been a long time since it has been cleaned. You can see a lot of broken things and dust all around. After entering another room, you see the silhouette of a really big person accompanied by a dog."
	
    let answer3a = "“Hey! Can you help me?”"
    let answer3b = "Hide and see what the person is up to."
    
	
    let story4 = "As time goes by, you start hearing footsteps near the room you’re in."
	
    let answer4a = "Exit the room."
    let answer4b = "Jump off the window."
    
	
    let story5 = "You talk nicely to the stranger about your situation and as you are talking, you notice a sharp looking knife in a table. The stranger seems weirded out about your situation and starts talking nonsense about how much he hates immigrants, getting angrier as he speaks. The dog also starts barking to you."
	
    let answer5a = "I’ll better grab that knife quickly."
    let answer5b = "I’ll be OK if I agree with him about his opinion on immigrants."
	
    
    let story6 = "As you crouch under some furniture, you are able to see a knife in a table, but a dog starts barking over at your direction, alerting the stranger of your presence."
	
    let answer6a = "Talk nicely to the stranger about your situation."
    let answer6b = "Try to grab the knife."
	
    
    let story7 = "As you run to the table to get the knife, you think about what a bad idea it was to run and try to grab a close range weapon while there’s an aggressive looking dog barking at you. You get killed."
	
	
    let story8 = "Since you’re obviously an immigrant, he doesn't seem convinced and takes you as a hostage until the ICE comes to deport you. They take you back to Venezuela, so in some way, a part of you gets killed."
	
	
    let story9 = "You sucessfully jump out of the window and die as a result of that decision."
    
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
            storyText.text = story2
            aButton.setTitle(answer2a, for: .normal)
            bButton.setTitle(answer2b, for: .normal)
            storyIndex = 2
            background.image = UIImage(named: backgrounds[0])
        }else if sender.tag == 1 && storyIndex == 1{
            storyText.text = story3
            aButton.setTitle(answer3a, for: .normal)
            bButton.setTitle(answer3b, for: .normal)
            storyIndex = 3
            background.image = UIImage(named: backgrounds[1])
        }
        // storyIndex == 2 (Y opción 1 de storyIndex == 4)
	    else if sender.tag == 0 && (storyIndex == 2 || storyIndex == 4) {
            storyText.text = story3
            aButton.setTitle(answer3a, for: .normal)
            bButton.setTitle(answer3b, for: .normal)
            storyIndex = 3
            background.image = UIImage(named: backgrounds[1])
        }else if sender.tag == 1 && storyIndex == 2 {
            storyText.text = story4
            aButton.setTitle(answer4a, for: .normal)
            bButton.setTitle(answer4b, for: .normal)
            storyIndex = 4
            background.image = UIImage(named: backgrounds[0])
        }
        // storyIndex == 3 (y opción 1 de storyIndex == 6)
	    else if sender.tag == 0 && (storyIndex == 3 || storyIndex == 6) {
            storyText.text = story5
            aButton.setTitle(answer5a, for: .normal)
            bButton.setTitle(answer5b, for: .normal)
            storyIndex = 5
            background.image = UIImage(named: backgrounds[2])
        }else if sender.tag == 1 && storyIndex == 3 {
            storyText.text = story6
            aButton.setTitle(answer6a, for: .normal)
            bButton.setTitle(answer6b, for: .normal)
            storyIndex = 6
            background.image = UIImage(named: backgrounds[2])
        }
        // storyIndex == 4
	    else if sender.tag == 1 && storyIndex == 4 {
            storyText.text = story9
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 9
            background.image = UIImage(named: backgrounds[3])
        }
        // storyIndex == 5
	    else if sender.tag == 0 && storyIndex == 5 {
            storyText.text = story7
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 7
            background.image = UIImage(named: backgrounds[3])
        }else if sender.tag == 1 && storyIndex == 5 {
            storyText.text = story8
            aButton.isHidden = true
            bButton.isHidden = true
            storyIndex = 8
            background.image = UIImage(named: backgrounds[3])
        }
        // storyIndex == 6
	    else if sender.tag == 1 && storyIndex == 6 {
            storyText.text = story7
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
        restartGame()
    }
    
	
    func restartGame() {
        storyIndex = 1
        storyText.text = story1
        aButton.isHidden = false
        bButton.isHidden = false
        aButton.setTitle(answer1a, for: .normal)
        bButton.setTitle(answer1b, for: .normal)
        restart.isHidden = true
        background.image = UIImage(named: backgrounds[0])
    }
}

