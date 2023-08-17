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
    private var animationComponent: StateMachineComponent?
    
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
        animationComponent = self.entity?.component(ofType: StateMachineComponent.self)
    }

    public func getAxis() -> CGPoint {
        return self.axis
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

            animationComponent?.stateMachine.enter(WalkState.self)
        } else {
            moveComponent?.change(direction: .zero)
            animationComponent?.stateMachine.enter(IdleState.self)
        }
    }
    
}
