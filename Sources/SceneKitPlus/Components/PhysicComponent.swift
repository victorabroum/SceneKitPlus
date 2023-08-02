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
    
    init(model: SCNNode) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        body = model.physicsBody
        body?.angularVelocityFactor = .init(x: 0, y: 0, z: 0)
        body?.friction = 1
        body?.damping = 0.2
        body?.mass = 12
    }
}
