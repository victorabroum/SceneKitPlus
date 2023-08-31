//
//  GameViewController+SetupGameController.swift
//  Stardew Palha
//
//  Created by Victor Vasconcelos on 02/08/23.
//

import Foundation
import GameKit
import GameplayKit

extension GameController {
    
    internal func observeGameControllers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didConnectController), name: .GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisconnectController), name: .GCControllerDidDisconnect, object: nil)
        
#if os(macOS)
        if #available(macOS 11.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(didConnectController), name: .GCKeyboardDidConnect, object: nil)
        }
#endif
    }
    
    @objc
    private func didConnectController() {
        for controller in GCController.controllers() {
            if controller.extendedGamepad != nil {
                controller.playerIndex = .index1
                setup(controller: controller)
            }
        }
        
        
#if os(macOS)
        if #available(macOS 11.0, *) {
            if let keyboard = GCKeyboard.coalesced {
                // (GCKeyboardInput, GCControllerButtonInput, GCKeyCode, Bool)
                keyboard.keyboardInput?.keyChangedHandler = { (keyInput, buttonInput, keyCode, isPressed) in
                    
                    var axis = self.moveAxis
                    
                    switch keyCode{
                    case .spacebar:
                        if (isPressed) {
                            self.didSpaceBarPressed()
                        } else {
                            self.didSpaceBarReleased()
                        }
                    case .keyA, .leftArrow:
                        axis.x = isPressed ? -1 : 0
                    case .keyD, .rightArrow:
                        axis.x = isPressed ? 1 : 0
                    case .keyW, .upArrow:
                        axis.y = isPressed ? 1 : 0
                    case .keyS, .downArrow:
                        axis.y = isPressed ? -1 : 0
                    default:
                        break
                    }
                    
                    self.moveAxis = axis
                }
            }
        }
#endif
    }
    
    @objc
    private func didDisconnectController() {
        
    }
    
    private func setup(controller: GCController) {
        controller.extendedGamepad?.valueChangedHandler = { [weak self] (gamepad: GCExtendedGamepad, element: GCControllerElement) in
            
            guard let self else { return }
            
            self.inputDetected(gamepad: gamepad, element: element, index: controller.playerIndex.rawValue)
            
            gamepad.buttonA.pressedChangedHandler = { (bt: GCControllerButtonInput, value: Float, isPressed: Bool) in
                if (isPressed) {
                    // Button is Pressed
                    self.didButtonAPressed()
                } else {
                    // Released the Button
                    self.didButtonAReleased()
                }
            }
            
            gamepad.buttonB.pressedChangedHandler = { (bt: GCControllerButtonInput, value: Float, isPressed: Bool) in
                if (isPressed) {
                    // Button is Pressed
                    self.didButtonBPressed()
                } else {
                    // Released the Button
                    self.didButtonBReleased()
                }
            }
            
        }
    }
    
    public func inputDetected(gamepad: GCExtendedGamepad, element: GCControllerElement, index: Int) {
        
        if (gamepad.leftThumbstick == element) {
            
            let xAxis = gamepad.leftThumbstick.xAxis.value // Horizontal Input
            let yAxis = gamepad.leftThumbstick.yAxis.value // Vertical Input
            
            let axis = CGPoint(x: CGFloat(xAxis), y: CGFloat(yAxis))
            
            self.moveAxis = axis
        }
    }
}
