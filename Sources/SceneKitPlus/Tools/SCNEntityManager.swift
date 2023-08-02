//
//  SCNEntityManager.swift
//
//  Created by Victor Vasconcelos on 24/05/23.
//

import Foundation
import GameplayKit
import SceneKit

public class SCNEntityManager {
    
    private var entities: [GKEntity] = []
    
    private var scene: SCNScene
    
    public init(scene: SCNScene) {
        self.scene = scene
    }
    
    public func add(entity: GKEntity) {
        
        // If has a node component add on Scene
        if let node = entity.component(ofType: GKSCNNodeComponent.self)?.node {
            self.scene.rootNode.addChildNode(node)
        }
        
        // A strong reference to entity
        self.entities.append(entity)
    }
    
    public func update(deltaTime: TimeInterval) {
        
        for entity in entities {
            entity.update(deltaTime: deltaTime)
        }
        
    }
    
}
