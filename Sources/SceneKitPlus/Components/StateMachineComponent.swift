//
//  StateMachineComponent.swift
//  
//
//  Created by Victor Vasconcelos on 17/08/23.
//

import Foundation
import GameplayKit

public class StateMachineComponent: GKComponent {

    public var stateMachine: GKStateMachine
    
    public init(stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

