//
//  GameViewController.swift
//  
//
//  Created by Victor Vasconcelos on 23/08/23.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

open class GameController: NSObject, SCNSceneRendererDelegate {

    public let sceneRenderer: SCNSceneRenderer
    
    public var scene: SCNScene?
    public var moveAxis: CGPoint = .zero
    
    public init(sceneRenderer renderer: SCNSceneRenderer, sceneName: String) {
        sceneRenderer = renderer
        self.scene = SCNScene(named: sceneName)
        super.init()
        
        sceneRenderer.delegate = self
        
        sceneRenderer.scene = scene
        
        observeGameControllers()
        
        sceneDidLoad()
    }
    
    open func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
    }
    
    open func sceneDidLoad() {
        
    }

}
