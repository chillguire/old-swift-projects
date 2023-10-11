//
//  ViewController.swift
//  ARRuler
//
//  Created by Ricardo Avendaño on 8/31/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

	var textNode = SCNNode()
	var Nodes = [SCNNode]()
	
	@IBOutlet var sceneView: ARSCNView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
		sceneView.delegate = self
	
		sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
	}
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        
		// Create a session configuration
		let configuration = ARWorldTrackingConfiguration()

		// Run the view's session
		sceneView.session.run(configuration)
	}
    
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
        
		// Pause the view's session
		sceneView.session.pause()
	}
	
	// MARK: - Functionality-wise methods
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		if Nodes.count >= 2 {
			for dot in Nodes {
				dot.removeFromParentNode()
			}
			Nodes = [SCNNode]()
		}
		
		if let touchLocation = touches.first?.location(in: sceneView) {
			
			let results = sceneView.hitTest(touchLocation, types: .featurePoint)
			
			if let hitResult = results.first {
				
				addDot(at: hitResult)
			}
		}
	}
	
	func addDot(at location: ARHitTestResult) {
	
		let cube = SCNBox(width: 0.005, height: 0.005, length: 0.005, chamferRadius: 0)

		let material = SCNMaterial()
		material.diffuse.contents = UIColor.purple
		cube.materials = [material]

		let node = SCNNode(geometry: cube)
		node.position = SCNVector3(
			x: location.worldTransform.columns.3.x,
			y: location.worldTransform.columns.3.y,
			z: location.worldTransform.columns.3.z)
		//node.geometry = cube

		sceneView.scene.rootNode.addChildNode(node)
		
		Nodes.append(node)
		if Nodes.count >= 2 {
			calculateDistance()
		}
	}
	
	func calculateDistance() {
		
		let start = Nodes[0]
		let end = Nodes[1]
		
		let a = end.position.x - start.position.x
		let b = end.position.y - start.position.y
		let c = end.position.z - start.position.z
		
		let distance = sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2))
		
		addText(text: "\(abs(distance) * 100) cm", atPosition: end.position)
	}
	
	func addText(text: String, atPosition position: SCNVector3) {
		
		textNode.removeFromParentNode()
		
		let textFigure = SCNText(string: text, extrusionDepth: 1.0)
		
		textFigure.firstMaterial?.diffuse.contents = UIColor.systemGroupedBackground
		
		textNode = SCNNode(geometry: textFigure)
		textNode.position = SCNVector3(
			x: position.x,
			y: position.y + 0.05,
			z: position.z - 0.05)
		textNode.scale = SCNVector3(0.05, 0.05, 0.05)
		
		sceneView.scene.rootNode.addChildNode(textNode)
	}

	// MARK: - ARSCNViewDelegate methods
    
}
