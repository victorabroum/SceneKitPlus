//
//  StateMachineComponent.swift
//  
//
//  Created by Victor Vasconcelos on 17/08/23.
//

import Foundation
import GameplayKit

public protocol BaseAnimationDelegate {
    var stateMachine: GKStateMachine? { get set }
    func enterWalk()
    func enterIdle()
}

open class StateMachineComponent: GKComponent {

    public var stateMachine: GKStateMachine
    
    public var delegate: BaseAnimationDelegate
    
    public init(stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        self.delegate = BaseAnimationStates(stateMachine: stateMachine)
        super.init()
    }
    
    public init(stateMachine: GKStateMachine, delegate: BaseAnimationDelegate) {
        self.stateMachine = stateMachine
        self.delegate = delegate
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class BaseAnimationStates: BaseAnimationDelegate {
    public var stateMachine: GKStateMachine?
    
    init(stateMachine: GKStateMachine? = nil) {
        self.stateMachine = stateMachine
    }
    
    public func enterWalk() {
        stateMachine?.enter(WalkState.self)
    }
    
    public func enterIdle() {
        stateMachine?.enter(IdleState.self)
    }
}
