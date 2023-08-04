//
//  CameraFollowComponent.swift
//  
//
//  Created by Victor Vasconcelos on 04/08/23.
//

import Foundation
import GameplayKit

public class CameraFollowComponent: GKComponent {
    
    public init(modelNode: SCNNode, cameraNode: SCNNode) {
        super.init()
        
//        let distanceConstraint = SCNDistanceConstraint(target: modelNode)
//        distanceConstraint.maximumDistance = 30.0
//        distanceConstraint.minimumDistance = 7.0
//
//        cameraNode.constraints = [distanceConstraint, SCNLookAtConstraint(target: modelNode)]
        
        let replicatorConstraint = SCNReplicatorConstraint(target: modelNode)
        replicatorConstraint.positionOffset = .init(cameraNode.position.x,
                                                    cameraNode.position.y,
                                                    cameraNode.position.z)
        
        replicatorConstraint.replicatesOrientation = false
        
        cameraNode.constraints = [replicatorConstraint, SCNLookAtConstraint(target: modelNode)]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
