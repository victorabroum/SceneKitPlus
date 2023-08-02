//
//  CharacterDataComponent.swift
//  
//
//  Created by Victor Vasconcelos on 02/08/23.
//

import Foundation
import GameplayKit

public class CharacterDataComponent: GKComponent {
    
    public var data: CharacterData
    
    public init(data: CharacterData) {
        self.data = data
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
