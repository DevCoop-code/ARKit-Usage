//
//  ViewController.swift
//  ARDrawingSimple
//
//  Created by HanGyo Jeong on 06/01/2019.
//  Copyright © 2019 HanGyoJeong. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var screenCenter: CGPoint?
    
    let session = ARSession();
    
    var virtualObjectManager: VirtualObjectManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
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
    
    func setupScene()
    {
        sceneView.setUp()
        sceneView.delegate = self
        sceneView.session = session
    }
    
    var focusSquare: 
    
    func updateFocusSquare()
    {
        guard let screenCenter = screenCenter else { return }
        
        DispatchQueue.main.async {
            var objectVisible = false
            for object in self.virtualObjectManager.virtualObjects{
                if self.sceneView.isNode(object, insideFrustumOf: self.sceneView.pointOfView!){
                    objectVisible = true
                    break
                }
            }
            
            if objectVisible{
                
            }else{
                
            }
        }
    }
    
    //pragma - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        updateFocusSquare()
    }
}
