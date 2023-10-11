//
//  ViewController.swift
//  WhatFlower
//
//  Created by Ricardo Avendaño on 8/27/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var label: UILabel!
	
	let imagePicker = UIImagePickerController()
	
	let wikipediaURL = "https://en.wikipedia.org/w/api.php"

	// MARK: - View loads
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePicker.delegate = self
		
		imagePicker.sourceType = .photoLibrary//camera
		imagePicker.allowsEditing = true
	}
	
	// MARK: - User has picked an image
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			
			guard let coreImage = CIImage(image: selectedImage) else {
				fatalError("Could not convert to CIImage.")
			}
			
			detect(image: coreImage)
			
			imageView.image = selectedImage
			
		}
		
		
		 
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Detect
	func detect(image: CIImage) {
		
		guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
			fatalError("Loading CoreML model failed.")
		}
		
		let request = VNCoreMLRequest(model: model) { (request, error) in
			
			guard let results = request.results?.first as? VNClassificationObservation else {
				fatalError("Could not fetch request nor process image")
			}
			
			self.classify(results: results)
		}
		
		let handler = VNImageRequestHandler(ciImage: image)
		do {
			try handler.perform([request])
		} catch {
			print(error)
		}
	}
	
	// MARK: - Classify
	func classify(results: VNClassificationObservation) {
		
		self.navigationItem.title = results.identifier.capitalized
		requestInfo(flowerName: results.identifier)
	}
	
	// MARK: - requestInfo - Alamofire networking
	func requestInfo(flowerName: String) {
		let parameters : [String : String] = [
			
			"format" : "json",
			"action" : "query",
			"prop" : "extracts|pageimages",
			"exintro" : "",
			"explaintext" : "",
			"titles" : flowerName,
			"indexpageids" : "",
			"redirects" : "1",
			"pithumbsize" : "500",
		]
		
/* https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts|pageimages&exintro=&explaintext=&titles=barberton%20daisy&redirects=1&pithumbsize=500&indexpageids */
		
		AF.request(wikipediaURL, method: .get, parameters: parameters).responseJSON { (response) in
			if case .success(let value) = response.result {
				print("Got the info")
				print(response)
			    
				let flowerJSON : JSON = JSON(value)
				
				let pageID = flowerJSON["query"]["pageids"][0].stringValue
				let flowerDescription = flowerJSON["query"]["pages"][pageID]["extract"].stringValue
				let flowerImageURL = flowerJSON["query"]["pages"][pageID]["thumbnail"]["source"].stringValue
				
				self.imageView.sd_setImage(with: URL(string: flowerImageURL))
				
				self.label.text = flowerDescription

			}
		}
	}
	// MARK: - Camera bar button gets tapped
	@IBAction func cameraTapped(_ sender: UIBarButtonItem) {
		present(imagePicker, animated: true, completion: nil)
	}
	
}

