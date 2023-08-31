//
//  GenericAnimState.swift
//
//  Created by Victor Vasconcelos on 17/08/23.
//

import Foundation
import GameplayKit

open class GenericAnimState: GKState {
    
    public weak var entity: GKEntity?
    public var animationName: String
    public var node: SCNNode?
    public var nextStates: [AnyClass]?
    
    public init(entity: GKEntity, animationName: String, nextStates: [AnyClass]? = nil) {
        self.entity = entity
        self.animationName = animationName
        self.nextStates = nextStates
        
        self.node = self.entity?.component(ofType: GKSCNNodeComponent.self)?.node
    }
    
    open override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        guard let nextStates else { return true }
        
        return nextStates.contains { obj in
            return obj == stateClass
        }
    }
    
    open override func didEnter(from previousState: GKState?) {
        self.node?.animationPlayer(forKey: animationName)?.play()
    }
    
    open override func willExit(to nextState: GKState) {
        self.node?.animationPlayer(forKey: animationName)?.stop(withBlendOutDuration: 0.1)
    }
}

public class IdleState: GenericAnimState { }
public class WalkState: GenericAnimState { }
