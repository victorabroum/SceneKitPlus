//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 02/08/23.
//

import Foundation

public struct CharacterData {
    
    var name: String
    var speed: CGFloat
    var jumpForce: CGFloat
    var prefixPath: String = "art.scnassets/"
    
    public static let defaultCharacter = CharacterData(name: "fox", speed: 4, jumpForce: 8)
    
    public init(name: String, speed: CGFloat, jumpForce: CGFloat, prefixPath: String = "art.scnassets/") {
        self.name = name
        self.speed = speed
        self.jumpForce = jumpForce
        self.prefixPath = prefixPath
    }
}
