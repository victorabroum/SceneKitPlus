//
//  MovementComponent.swift
//
//  Created by Victor Vasconcelos on 25/05/23.
//

import Foundation
import GameplayKit
import SceneKit

public class MovementComponent: GKComponent {
    
    private var speed: CGFloat
    private var model: SCNNode?
    private var direction: CGPoint = .zero
    private var jumpForce: CGFloat
    
    private var physicsComponent: PhysicsComponent?
    
    public init(speed: CGFloat, jumpForce: CGFloat = 2) {
        self.speed = speed
        self.jumpForce = jumpForce
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        physicsComponent = self.entity?.component(ofType: PhysicsComponent.self)
//        model = self.entity?.component(ofType: ModelComponent.self)?.model
        let data = self.entity?.component(ofType: CharacterDataComponent.self)?.data
        model = self.entity?.component(ofType: GKSCNNodeComponent.self)?.node.childNode(withName: "\(data?.name ?? "")", recursively: true)
    }
    
    public func change(direction: CGPoint) {
        self.direction = direction
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        
        guard direction != .zero else {
            self.physicsComponent?.body?.velocity = .init(x: 0, y: 0, z: 0)
            return
        }
        
        let angle = atan2(direction.x, direction.y)
        let rotation: SCNVector4 = .init(0, 1, 0, angle)
        model?.runAction(.rotate(toAxisAngle: rotation, duration: 0.01))
        
        let direction = SCNVector3(x: CGFloat(Float(direction.x * speed)),
                                   y: 0,
                                   z: CGFloat(direction.y * speed))
        
        self.physicsComponent?.body?.velocity = direction
    }

}
