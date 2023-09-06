//
//  SceneKitAnimationTools.swift
//
//  Created by Victor Vasconcelos on 02/08/23.
//

import Foundation
import SceneKit

public struct SCNAnimationTools {
    
    public static func loadAnimation(fromSceneNamed sceneName: String) -> SCNAnimationPlayer? {
        guard let scene = SCNScene( named: sceneName ) else { return nil }
        // Find the top-level animation.
        var animationPlayer: SCNAnimationPlayer! = nil
        scene.rootNode.enumerateChildNodes { (child, stop) in
            if !child.animationKeys.isEmpty {
                animationPlayer = child.animationPlayer(forKey: child.animationKeys[0])
                stop.pointee = true
            }
        }
        return animationPlayer
    }
    
    public static func subAnimation(of fullAnimation: CAAnimation, startFrame:Int, endFrame:Int) -> CAAnimation {
        let (startTime, duration) = timeRange(startFrame:startFrame, endFrame:endFrame)
        let animation = subAnimation(of: fullAnimation, offset: startTime, duration: duration)
        return animation
    }

    public static func subAnimation(of fullAnimation: CAAnimation,
                             offset timeOffset: CFTimeInterval,
                             duration:CFTimeInterval) -> CAAnimation {
        fullAnimation.timeOffset = timeOffset
        let container = CAAnimationGroup()
        container.animations = [fullAnimation]
        container.duration = duration
        return container
    }
    
    public static func timeRange(startFrame:Int, endFrame:Int) -> (startTime:CFTimeInterval, duration:CFTimeInterval) {
        let startTime = timeOf(frame:startFrame)
        let endTime = timeOf(frame:endFrame)
        let duration = endTime - startTime
        return (startTime, duration)
    }
    
    public static func timeOf(frame:Int) -> CFTimeInterval {
        return CFTimeInterval(frame) / framesPerSecond()
    }

    public static func framesPerSecond() -> CFTimeInterval {
        // number of frames per second the model was designed with
        return 24.0
    }
}
