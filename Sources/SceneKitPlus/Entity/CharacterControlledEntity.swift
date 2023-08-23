//
//  CharacterControlledEntity.swift
//
//  Created by Victor Vasconcelos on 24/05/23.
//

import Foundation
import GameplayKit
import SceneKit

open class CharacterControlledEntity: GKEntity {
    
    public var controllerComp: CharacterControllerComponent?
    public var animStateComp: StateMachineComponent?
    
    public init(characterData: CharacterData, cameraNode: SCNNode?) {
        super.init()
        
        self.addComponent(CharacterDataComponent(data: characterData))
        
        // Node component
        if let scene = SCNScene(named: characterData.prefixPath + characterData.name + ".scn"),
           let modelNode = scene.rootNode.childNode(withName: "\(characterData.name)", recursively: true),
           let boydNode = scene.rootNode.childNode(withName: "body", recursively: true){

            let nodeComponent = GKSCNNodeComponent(node: scene.rootNode)
            self.addComponent(nodeComponent)
            
            // Physics Component
            let physicsComp = PhysicsComponent(model: boydNode)
            self.addComponent(physicsComp)
            
            // Camera Follow Component
            if let cameraNode {
                self.addComponent(CameraFollowComponent(modelNode: modelNode, cameraNode: cameraNode))
            }
        }
        
        // Animation component
        setupAnimationComponent(data: characterData)
        
        // Animation State Component
        setupAnimStateComp()
        
        // Move Component
        setupMoveComponent(characterData: characterData)
        
        // Controller Component
        setupControllerComponent(cameraNode: cameraNode ?? SCNNode())
    }
    
    open func setupAnimStateComp() {
        animStateComp = .init(stateMachine: .init(states: [
            IdleState(entity: self, animationName: "idle"),
            WalkState(entity: self, animationName: "walk", nextStates: [IdleState.self])
        ]))
        animStateComp?.stateMachine.enter(IdleState.self)
    }
    
    open func setupAnimationComponent(data: CharacterData) {
        let animationComp = AnimationComponent(data: data)
        self.addComponent(animationComp)

        animationComp.addAnimation(named: "walk", frameRange: 81...96)
        animationComp.addAnimation(named: "idle", frameRange: 0...80)
    }
    
    open func setupMoveComponent(characterData: CharacterData) {
        let moveComp = MovementComponent(speed: characterData.speed,
                                         jumpForce: characterData.jumpForce)
        self.addComponent(moveComp)
    }
    
    open func setupControllerComponent(cameraNode: SCNNode){
        controllerComp = CharacterControllerComponent(cameraNode: cameraNode)
        self.addComponent(controllerComp!)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
