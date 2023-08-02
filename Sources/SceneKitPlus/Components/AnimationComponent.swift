//
//  AnimationComponent.swift
//
//  Created by Victor Vasconcelos on 24/05/23.
//

import Foundation
import GameplayKit
import SceneKit

public class AnimationComponent: GKComponent {
    
    private var nodeNamed: String
    
    private var node: SCNNode?
    private var lastAnimationNamed: String = ""
    
    public init(named: String) {
        self.nodeNamed = named
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
                             repeatCount: Float = -1) {
        guard let animationPlayer = SCNAnimationTools.loadAnimation(fromSceneNamed: "art.scnassets/" + nodeNamed + ".scn") else { return }
        
        let fullAnimaiton = CAAnimation(scnAnimation: animationPlayer.animation)
        let subAnimation = SCNAnimationTools.subAnimation(of: fullAnimaiton,
                                                          startFrame: frameRange.lowerBound,
                                                          endFrame: frameRange.upperBound)
        subAnimation.repeatCount = repeatCount
        self.node?.addAnimation(subAnimation, forKey: named)
        self.node?.animationPlayer(forKey: named)?.stop()
    }
    
    public func playAnimation(named: String) {
        if named == lastAnimationNamed { return }
        
        self.node?.animationPlayer(forKey: lastAnimationNamed)?.stop(withBlendOutDuration: 0.1)
        self.node?.animationPlayer(forKey: named)?.play()
        lastAnimationNamed = named
    }
}
