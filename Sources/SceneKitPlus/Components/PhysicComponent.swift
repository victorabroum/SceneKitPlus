//
//  PhysicComponent.swift
//
//  Created by Victor Vasconcelos on 26/05/23.
//

import Foundation
import GameplayKit
import SceneKit

public class PhysicsComponent: GKComponent {
    
    private var model: SCNNode
    
    public var body: SCNPhysicsBody?
    
    public init(model: SCNNode) {
        self.model = model
        super.init()
        
        self.body = model.physicsBody
    }
    
    public init(model: SCNNode, body: SCNPhysicsBody) {
        self.model = model
        super.init()
        
        self.model.physicsBody = body
        self.body = body
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.model.physicsBody = nil
    }
}
