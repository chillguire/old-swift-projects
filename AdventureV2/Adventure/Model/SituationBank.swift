//
//  SituationBank.swift
//  Adventure
//
//  Created by Ricardo Avendaño on 4/24/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import Foundation

class SituationBank {
	
	var list = [Situation]()
	
	init() {
				
		let story1 = Situation(text: "You just woke up in a place you can’t recognize after going to celebrate that you were able to leave Venezuela, and you’re currently feeling a really bad headache that doesn’t let you remember anything about the reason you could be in here. As you look around for your phone without success, you see a TV turned on with the local news in it.", aAnswer: "Maybe the news will help me figure out where I am.", bAnswer: "Maybe I got drunk and I’m still feeling sick, I’ll look around to see if I remember anything.")
		list.append(story1)
		
		
		list.append(Situation(text: "You get close to the TV in order to gather useful information about the place you’re in. Unfortunately, you see that the TV has no sound, and you’re unable to read the words that appear on TV since you never learned how to read. However, you see the US flag hanging above the TV, and besides there’s a confederate flag, the flag of a group known because of their tendencies towards racism practices against people of color.", aAnswer: "Well, it’ll be better if I explore this place carefully.", bAnswer: "I can't explore this place in this state. I’ll better stay resting here and hide if something happens."))
		
		
		list.append(Situation(text: "You start walking around the house and note that it’s been a long time since it has been cleaned. You can see a lot of broken things and dust all around. After entering another room, you see the silhouette of a really big person accompanied by a dog.", aAnswer: "“Hey! Can you help me?”", bAnswer: "Hide and see what the person is up to."))
		
		
		list.append(Situation(text: "As time goes by, you start hearing footsteps near the room you’re in.", aAnswer: "Exit the room.", bAnswer: "Jump off the window."))
		
		
		list.append(Situation(text: "You talk nicely to the stranger about your situation and as you are talking, you notice a sharp looking knife in a table. The stranger seems weirded out about your situation and starts talking nonsense about how much he hates immigrants, getting angrier as he speaks. The dog also starts barking to you.", aAnswer: "I’ll better grab that knife quickly.", bAnswer: "I’ll be OK if I agree with him about his opinion on immigrants."))
		
		
		list.append(Situation(text: "As you crouch under some furniture, you are able to see a knife in a table, but a dog starts barking over at your direction, alerting the stranger of your presence.", aAnswer: "Talk nicely to the stranger about your situation.", bAnswer: "Try to grab the knife."))
		
		
		list.append(Situation(text: "As you run to the table to get the knife, you think about what a bad idea it was to run and try to grab a close range weapon while there’s an aggressive looking dog barking at you. You get killed.", aAnswer: "", bAnswer: ""))
		
		
		list.append(Situation(text: "Since you’re obviously an immigrant, he doesn't seem convinced and takes you as a hostage until the ICE comes to deport you. They take you back to Venezuela, so in some way, a part of you gets killed.", aAnswer: "", bAnswer: ""))
		
		
		list.append(Situation(text: "You sucessfully jump out of the window and die as a result of that decision.", aAnswer: "", bAnswer: ""))
	}
}
