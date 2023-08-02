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
    
    public init(characterData: CharacterData, cameraNode: SCNNode) {
        super.init()
        
        // Node component
        if let scene = SCNScene(named: "Assets/" + characterData.name + ".scn"),
           let boydNode = scene.rootNode.childNode(withName: "body", recursively: true){
            
//            ,
//            let modelNode = scene.rootNode.childNode(withName: named, recursively: true)
            
            let nodeComponent = GKSCNNodeComponent(node: scene.rootNode)
            self.addComponent(nodeComponent)
            
//            self.addComponent(ModelComponent(model: modelNode))
            
            let physicsComp = PhysicsComponent(model: boydNode)
            self.addComponent(physicsComp)
        }
        
        // Animation component
        let animationComp = AnimationComponent(named: characterData.name)
        self.addComponent(animationComp)

        animationComp.addAnimation(named: "fall", frameRange: 135...174)
        animationComp.addAnimation(named: "jump", frameRange: 118...134)
        animationComp.addAnimation(named: "attack", frameRange: 97...117)
        animationComp.addAnimation(named: "walk", frameRange: 81...96)
        animationComp.addAnimation(named: "idle", frameRange: 0...80)
        
        animationComp.playAnimation(named: "idle")
        
        let moveComp = MovementComponent(speed: 4, jumpForce: 8)
        self.addComponent(moveComp)
        
        controllerComp = CharacterControllerComponent(cameraNode: cameraNode)
        self.addComponent(controllerComp!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
