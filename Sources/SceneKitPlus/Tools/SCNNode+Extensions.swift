//
//  SCNNode+Extensions.swift
//  
//
//  Created by Victor Vasconcelos on 04/09/23.
//

import Foundation
import SceneKit

public extension SCNNode {
    
    static func getRootNode(from node: SCNNode) -> SCNNode {
        if let parent = node.parent {
            return getRootNode(from: parent)
        }
        return node
    }
}
