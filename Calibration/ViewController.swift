//
//  ViewController.swift
//  Calibration
//
//  Created by Developer on 9/21/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        
        
        let g = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        g.firstMaterial?.diffuse.contents = UIColor.purple
        let ball = SCNNode(geometry: g)
        ball.position = SCNVector3(x: -1.48086596, y: -0.0808541551, z: -0.0840704888)
        sceneView.scene.rootNode.addChildNode(ball)
        
        
        
        
        

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self.view)
            
            if location.x < self.view.frame.width / 2 {
                print(sceneView.session.currentFrame!.camera.transform.position)
                
                let g = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
                g.firstMaterial?.diffuse.contents = UIColor.purple
                let ball = SCNNode(geometry: g)
                ball.position = sceneView.session.currentFrame!.camera.transform.position
                sceneView.scene.rootNode.addChildNode(ball)
                
                
            } else {
                let config = ARWorldTrackingConfiguration()
                sceneView.session.run(config, options: .resetTracking)
                print("reset: \(sceneView.session.currentFrame!.camera.transform.position)")
                

                let g = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
                g.firstMaterial?.diffuse.contents = UIColor.purple
                let ball = SCNNode(geometry: g)
                ball.position = SCNVector3(x: -1.48086596, y: -0.0808541551, z: -0.0840704888)
                sceneView.scene.rootNode.addChildNode(ball)
            }
        
        }
    }
}

extension matrix_float4x4 {
    var position: SCNVector3 {
        return SCNVector3(columns.3.x, columns.3.y, columns.3.z)
    }
}
