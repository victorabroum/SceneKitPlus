//
//  CharacterControlledEntity.swift
//
//  Created by Victor Vasconcelos on 24/05/23.
//

import Foundation
import GameplayKit
import SceneKit

public class CharacterControlledEntity: GKEntity {
    
    public var controllerComp: CharacterControllerComponent?
    public var animStateComp: StateMachineComponent?
    
    public init(characterData: CharacterData, cameraNode: SCNNode, cameraFollowEnabled: Bool = false) {
        super.init()
        
        self.addComponent(CharacterDataComponent(data: characterData))
        
        // Node component
        if let scene = SCNScene(named: characterData.prefixPath + characterData.name + ".scn"),
           let modelNode = scene.rootNode.childNode(withName: "\(characterData.name)", recursively: true),
           let boydNode = scene.rootNode.childNode(withName: "body", recursively: true){

            let nodeComponent = GKSCNNodeComponent(node: scene.rootNode)
            self.addComponent(nodeComponent)
            
            let physicsComp = PhysicsComponent(model: boydNode)
            self.addComponent(physicsComp)
            
            if (cameraFollowEnabled) {
                self.addComponent(CameraFollowComponent(modelNode: modelNode, cameraNode: cameraNode))
            }
        }
        
        // Animation component
        let animationComp = AnimationComponent(data: characterData)
        self.addComponent(animationComp)

        animationComp.addAnimation(named: "walk", frameRange: 81...96)
        animationComp.addAnimation(named: "idle", frameRange: 0...80)
        
        animStateComp = .init(stateMachine: .init(states: [
            IdleState(entity: self, animationName: "idle"),
            WalkState(entity: self, animationName: "walk")
        ]))
        
        let moveComp = MovementComponent(speed: characterData.speed,
                                         jumpForce: characterData.jumpForce)
        self.addComponent(moveComp)
        
        controllerComp = CharacterControllerComponent(cameraNode: cameraNode)
        self.addComponent(controllerComp!)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
