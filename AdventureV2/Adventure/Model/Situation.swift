//
//  Question.swift
//  Adventure
//
//  Created by Ricardo Avendaño on 4/24/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import Foundation

class Situation {
	
	let situationText : String
	let answerA : String
	let answerB : String
	
	init(text: String, aAnswer : String, bAnswer : String) {
		situationText = text
		answerA = aAnswer
		answerB = bAnswer
	}
}
