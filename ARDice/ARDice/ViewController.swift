//
//  ViewController.swift
//  ARDice
//
//  Created by Ricardo Avendaño on 8/28/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

	var diceArray = [SCNNode]()
	
	@IBOutlet var sceneView: ARSCNView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
		// used to show the process of recognizing things. remove if going to production
		self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
	
		sceneView.delegate = self
        
//		let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 1)
//
//		let esfera = SCNSphere(radius: 0.2)
//
//		let material = SCNMaterial()
//		material.diffuse.contents = UIColor.red
//		esfera//cube.materials = [material] // expects array
//
//		let node = SCNNode()
//		node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
//		node.geometry = esfera//cube
//
//		sceneView.scene.rootNode.addChildNode(node)
	
		sceneView.autoenablesDefaultLighting = true
	}
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// if device have a9 chip
		if ARWorldTrackingConfiguration.isSupported {
			
			// Create a session configuration
			let configuration = ARWorldTrackingConfiguration()
			
			configuration.planeDetection = .horizontal
			
			// Run the view's session
			sceneView.session.run(configuration)
			
		// if it doesn't have a9 chip
		} else if AROrientationTrackingConfiguration.isSupported {
			
			let configuration = AROrientationTrackingConfiguration()
			sceneView.session.run(configuration)
		}
	}
    
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
        
		// Pause the view's session
		sceneView.session.pause()
	}
	
	// MARK: - Dice rendering methods

	//Function than handles the touching capabilities
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		if let touch = touches.first {
			
			let touchLocation = touch.location(in: sceneView)

			let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
			
			if let hitResult = results.first {
				addDice(atLocation: hitResult)
			}
		}
	}
	
	// creating new dice
	func addDice(atLocation location: ARHitTestResult) {

		let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")

		if let diceNode = diceScene?.rootNode.childNode(withName: "Dice", recursively: true) {

			diceNode.position = SCNVector3(
				/*
				column 0 = x,
				column 1 = y,
				column 2 = z,
				column 3 = position
				*/
				x: location.worldTransform.columns.3.x,
				y: location.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
				z: location.worldTransform.columns.3.z)
			
			diceArray.append(diceNode)
			sceneView.scene.rootNode.addChildNode(diceNode)
			
			roll(dice: diceNode)
		}
	}
	
	//rolling animation
	func roll(dice: SCNNode) {
		
		let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
		let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
		
		dice.runAction(
			SCNAction.rotateBy(
				x: CGFloat(randomX * 10),
				y: 0,
				z: CGFloat(randomZ * 10),
				duration: 0.25)
		)
	}
	
	func rollAll() {
		if !diceArray.isEmpty {
			for dice in diceArray {
				roll(dice: dice)
			}
		}
	}
	
	@IBAction func rollAgain(_ sender: UIBarButtonItem) {
		rollAll()
	}
	
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		rollAll()
	}
	
	@IBAction func removeAllDice(_ sender: UIBarButtonItem) {
	
		if !diceArray.isEmpty {
			for dice in diceArray {
				dice.removeFromParentNode()
			}
		}
	}
	
    // MARK: - ARSCNViewDelegate methods
	
	//Code that gets triggered when a horizontal/vertical plane gets detected.
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
		
		guard let planeAnchor = anchor as? ARPlaneAnchor else {
			return
		}

		let planeNode = createPlane(withPlaneanchor: planeAnchor)
		
		node.addChildNode(planeNode)

	}
	
	func createPlane(withPlaneanchor planeAnchor: ARPlaneAnchor) -> SCNNode{
		let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
		
		let planeNode = SCNNode()
		planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
		// planes by default are in the y and x axis, so you need to rotate them so they're in the z and x axis.
		planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
		
		let gridMaterial = SCNMaterial()
		gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/overlay_grid.png")
		plane.materials = [gridMaterial]
		
		planeNode.geometry = plane
		
		return planeNode
	}
}
