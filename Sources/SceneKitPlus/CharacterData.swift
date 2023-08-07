//
//  File.swift
//  
//
//  Created by Victor Vasconcelos on 02/08/23.
//

import Foundation

public struct CharacterData {
    
    public var name: String
    public var speed: CGFloat
    public var jumpForce: CGFloat
    public var prefixPath: String = "art.scnassets/"
    
    public static let defaultCharacter = CharacterData(name: "fox", speed: 1.5, jumpForce: 4)
    
    public init(name: String, speed: CGFloat, jumpForce: CGFloat, prefixPath: String = "art.scnassets/") {
        self.name = name
        self.speed = speed
        self.jumpForce = jumpForce
        self.prefixPath = prefixPath
    }
}
