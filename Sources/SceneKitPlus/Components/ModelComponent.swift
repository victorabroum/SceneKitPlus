//
//  ModelComponent.swift
//  
//
//  Created by Victor Vasconcelos on 29/08/23.
//

import Foundation
import GameplayKit

open class ModelComponent: GKComponent {
    open var position: SCNVector3
    public var model: SCNNode
    
    public init(body: SCNNode) {
        self.model = body
        self.position = body.presentation.position
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
