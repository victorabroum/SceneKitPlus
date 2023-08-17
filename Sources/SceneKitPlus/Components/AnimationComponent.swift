//
//  AnimationComponent.swift
//
//  Created by Victor Vasconcelos on 24/05/23.
//

import Foundation
import GameplayKit
import SceneKit

public class AnimationComponent: GKComponent {
    
    private var data: CharacterData
    
    private var node: SCNNode?
    
    public init(data: CharacterData) {
        self.data = data
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {

        self.node = self.entity?.component(ofType: GKSCNNodeComponent.self)?.node
        self.node?.removeAllAnimations()
    }
    
    public func addAnimation(named: String,
                             frameRange: ClosedRange<Int>,
                             repeatCount: Float = .greatestFiniteMagnitude) {
        guard let animationPlayer = SCNAnimationTools.loadAnimation(fromSceneNamed: data.prefixPath + data.name + ".scn") else { return }
        
        let fullAnimaiton = CAAnimation(scnAnimation: animationPlayer.animation)
        let subAnimation = SCNAnimationTools.subAnimation(of: fullAnimaiton,
                                                          startFrame: frameRange.lowerBound,
                                                          endFrame: frameRange.upperBound)
        subAnimation.repeatCount = repeatCount
        self.node?.addAnimation(subAnimation, forKey: named)
        self.node?.animationPlayer(forKey: named)?.stop()
    }
}
