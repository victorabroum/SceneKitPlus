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

    open var moveAxis: CGPoint = .zero
    open var entityManager: SCNEntityManager?
    
    public var scene: SCNScene?
    public var lastUpdateTime: TimeInterval = 0.0
    
    public let sceneRenderer: SCNSceneRenderer

    public init(sceneRenderer renderer: SCNSceneRenderer, sceneName: String) {
        sceneRenderer = renderer
        self.scene = SCNScene(named: sceneName)
        if let scene {
            entityManager = SCNEntityManager(scene: scene)
        }
        super.init()
        
        sceneRenderer.delegate = self
        
        sceneRenderer.scene = scene
        
        observeGameControllers()
        
        sceneDidLoad()
    }
    
    open func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = time
        }
        
        // Calculate time since last update
        let deltaTime = time - self.lastUpdateTime
        self.lastUpdateTime = time
        
        entityManager?.update(deltaTime: deltaTime)
        
    }
    
    open func sceneDidLoad() {
        
    }

}
