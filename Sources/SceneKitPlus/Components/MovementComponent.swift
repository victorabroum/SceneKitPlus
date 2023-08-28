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
        let data = self.entity?.component(ofType: CharacterDataComponent.self)?.data
        model = self.entity?.component(ofType: GKSCNNodeComponent.self)?.node.childNode(withName: "\(data?.name ?? "")", recursively: true)
    }
    
    public func change(direction: CGPoint) {
        self.direction = direction
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        
        
        let velocityY = self.physicsComponent?.body?.velocity.y ?? 0
        
        guard direction != .zero else {
            self.physicsComponent?.body?.velocity = .init(x: 0, y: velocityY, z: 0)
            return
        }
        
        let angle = atan2(direction.x, direction.y)
        let rotation: SCNVector4 = .init(0, 1, 0, angle)
        
        model?.runAction(.rotateTo(
            x: CGFloat(rotation.x),
            y: CGFloat(angle),
            z: CGFloat(rotation.z), //
            duration: 0.1, usesShortestUnitArc: true))
        
        let direction = SCNVector3(x: SCNFloat(direction.x * speed),
                                   y: velocityY,
                                   z: SCNFloat(direction.y * speed))
        
        self.physicsComponent?.body?.velocity = direction
    }

}
