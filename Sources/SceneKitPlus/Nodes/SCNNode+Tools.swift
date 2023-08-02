//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 02/08/23.
//

import Foundation
import SceneKit

extension SCNNode {
    public func removeAllChildrens() {
        for node in self.childNodes {
            node.removeFromParentNode()
        }
    }
}
