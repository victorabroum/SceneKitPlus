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
    
    public static let defaultCharacter = CharacterData(name: "fox", speed: 4, jumpForce: 8)
}
