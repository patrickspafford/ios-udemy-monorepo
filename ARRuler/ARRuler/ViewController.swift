//
//  ViewController.swift
//  ARRuler
//
//  Created by Patrick Spafford on 9/25/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var dotNodes: [SCNNode] = []
    var textNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        
    }
    
    func calculate() {
        let start = dotNodes[0].position
        let end = dotNodes[1].position
        let xComponent = pow(end.x - start.x, 2.0)
        let yComponent = pow(end.y - start.y, 2.0)
        let zComponent = pow(end.z - start.z, 2.0)
        let total = pow(xComponent + yComponent + zComponent, (1 / 2))
        updateText(text: "\(total)", atPosition: end)
    }
    
    func updateText(text: String, atPosition position: SCNVector3) {
        if let existingTextNode = textNode {
            existingTextNode.removeFromParentNode()
        }
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.blue
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = position
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        sceneView.scene.rootNode.addChildNode(textNode)
        self.textNode = textNode
    }
    
    func addDot(at location: ARRaycastResult) {
        if dotNodes.count >= 2 {
            for dot in dotNodes {
                dot.removeFromParentNode()
            }
            dotNodes = []
        }
        print("Adding dot")
        let sphere = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        sphere.materials = [material]
        let sphereNode = SCNNode(geometry: sphere)
        let locationBase = location.worldTransform.columns.3
        sphereNode.position = SCNVector3(
            x: locationBase.x,
            y: locationBase.y,
            z: locationBase.z)
        sceneView.scene.rootNode.addChildNode(sphereNode)
        dotNodes.append(sphereNode)
        if dotNodes.count >= 2 {
            calculate()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            print("Touch location: \(touchLocation)")
            let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .horizontal)
            guard let safeQuery = query else {return}
            let results = sceneView.session.raycast(safeQuery)
            print("Results: \(results)")
            if !results.isEmpty {
                addDot(at: results.first!)
            }
        }
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

    
}
