//
//  CharacterControllerComponent.swift
//
//  Created by Victor Vasconcelos on 26/05/23.
//

import Foundation
import GameplayKit

public class CharacterControllerComponent: GKComponent {
    
    private var cameraNode: SCNNode
    private var moveComponent: MovementComponent?
    private var animationComponent: AnimationComponent?
    
    private var axis: CGPoint = .zero
    
    public init(cameraNode: SCNNode) {
        self.cameraNode = cameraNode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        moveComponent = self.entity?.component(ofType: MovementComponent.self)
        animationComponent = self.entity?.component(ofType: AnimationComponent.self)
    }
    
    public func change(x: CGFloat) {
        self.move(axis: .init(x: x, y: axis.y))
    }
    
    public func change(y: CGFloat) {
        self.move(axis: .init(x: axis.x, y: y))
    }
    
    public func move(axis: CGPoint) {
        
        self.axis = axis
        
        if (axis != .zero) {
            
            var forward = self.cameraNode.worldFront
            var right = self.cameraNode.worldRight
            
            forward.y = 0
            right.y = 0
            
            forward = forward.normalized()
            right = right.normalized()
            
            let rightRelative = right * axis.x
            let forwardRelative = forward * axis.y
            
            let cameraRelative = forwardRelative + rightRelative
            
            let relativeDirection = CGPoint(
                x: CGFloat(cameraRelative.x),
                y: CGFloat(cameraRelative.z))
            
            moveComponent?.change(direction: relativeDirection)
            animationComponent?.playAnimation(named: "walk")
        } else {
            moveComponent?.change(direction: .zero)
            animationComponent?.playAnimation(named: "idle")
        }
    }
    
    public func tryToAttack() {
        animationComponent?.playAnimation(named: "attack")
    }
    
}
