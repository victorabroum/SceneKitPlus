//
//  SCNVector3Tools.swift
//  AnimationStudy
//
//  Created by Victor Vasconcelos on 25/05/23.
//

import Foundation
import GameplayKit

extension SCNVector3 {
    
    /**
     * Returns the length (magnitude) of the vector described by the SCNVector3
     */
    func length() -> Float {
        let xD = x * x
        let yD = y * y
        let zD = z * z
        return Float(sqrt(xD + yD + zD))
    }
    
    mutating func setLength(_ length: CGFloat) {
        self.normalize()
        self *= length
    }
    
    mutating func setMaximumLength(_ maxLength: CGFloat) {
        if CGFloat(self.length()) <= maxLength {
            return
        } else {
            self.normalize()
            self *= maxLength
        }
    }
    
    mutating func normalize() {
        self = self.normalized()
    }
    
    func normalized() -> SCNVector3 {
        if self.length() == 0 {
            return self
        }
        return self / CGFloat(self.length())
    }
    
    /**
     * Negates the vector described by SCNVector3 and returns
     * the result as a new SCNVector3.
     */
    func negate() -> SCNVector3 {
        return self * -1
    }
    
    /**
     * Negates the vector described by SCNVector3
     */
    mutating func negated() -> SCNVector3 {
        self = negate()
        return self
    }
    
    /**
     * Calculates the distance between two SCNVector3. Pythagoras!
     */
    func distance(vector: SCNVector3) -> Float {
        return (self - vector).length()
    }
    
    func toString() -> String
    {
        return "SCNVector3(x:\(x), y:\(y), z:\(z)"
    }
    
    // Return the angle between this vector and the specified vector v
    func angle(v: SCNVector3) -> Float
    {
        // angle between 3d vectors P and Q is equal to the arc cos of their dot products over the product of
        // their magnitudes (lengths).
        //    theta = arccos( (P • Q) / (|P||Q|) )
        let dp = dot(v) // dot product
        let magProduct = length() * v.length() // product of lengths (magnitudes)
        return acos(Float(dp) / magProduct) // DONE
    }
    
    mutating func constrain(min: SCNVector3, max: SCNVector3) -> SCNVector3 {
        if(x < min.x) { self.x = min.x }
        if(x > max.x) { self.x = max.x }
        
        if(y < min.y) { self.y = min.y }
        if(y > max.y) { self.y = max.y }
        
        if(z < min.z) { self.z = min.z }
        if(z > max.z) { self.z = max.z }
        
        return self
    }
    
    static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(CGFloat(transform.columns.3.x), CGFloat(transform.columns.3.y), CGFloat(transform.columns.3.z))
    }
    
    func friendlyString() -> String {
        return "(\(String(format: "%.2f", x)), \(String(format: "%.2f", y)), \(String(format: "%.2f", z)))"
    }
    
    func dot(_ vec: SCNVector3) -> CGFloat {
        let xD = (self.x * vec.x)
        let yD = (self.y * vec.y)
        let zD = (self.z * vec.z)
        return xD + yD + zD
    }
    
    func cross(_ vec: SCNVector3) -> SCNVector3 {
        return SCNVector3(self.y * vec.z - self.z * vec.y, self.z * vec.x - self.x * vec.z, self.x * vec.y - self.y * vec.x)
    }
    /**
     * Adds two SCNVector3 vectors and returns the result as a new SCNVector3.
     */
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    /**
     * Increments a SCNVector3 with the value of another.
     */
    static func += ( left: inout SCNVector3, right: SCNVector3) {
        left = left + right
    }
    
    /**
     * Subtracts two SCNVector3 vectors and returns the result as a new SCNVector3.
     */
    static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    /**
     * Decrements a SCNVector3 with the value of another.
     */
    static func -= ( left: inout SCNVector3, right: SCNVector3) {
        left = left - right
    }
    
    /**
     * Multiplies two SCNVector3 vectors and returns the result as a new SCNVector3.
     */
    static func * (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x * right.x, left.y * right.y, left.z * right.z)
    }
    
    /**
     * Multiplies a SCNVector3 with another.
     */
    static func *= ( left: inout SCNVector3, right: SCNVector3) {
        left = left * right
    }
    
    /**
     * Multiplies the x, y and z fields of a SCNVector3 with the same scalar value and
     * returns the result as a new SCNVector3.
     */
    static func * (vector: SCNVector3, scalar: CGFloat) -> SCNVector3 {
        return SCNVector3Make(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }
    
    /**
     * Multiplies the x and y fields of a SCNVector3 with the same scalar value.
     */
    static func *= ( vector: inout SCNVector3, scalar: CGFloat) {
        vector = vector * scalar
    }
    
    /**
     * Divides two SCNVector3 vectors abd returns the result as a new SCNVector3
     */
    static func / (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x / right.x, left.y / right.y, left.z / right.z)
    }
    
    /**
     * Divides a SCNVector3 by another.
     */
    static func /= ( left: inout SCNVector3, right: SCNVector3) {
        left = left / right
    }
    
    /**
     * Divides the x, y and z fields of a SCNVector3 by the same scalar value and
     * returns the result as a new SCNVector3.
     */
    static func / (vector: SCNVector3, scalar: CGFloat) -> SCNVector3 {
        return SCNVector3Make(vector.x / scalar, vector.y / scalar, vector.z / scalar)
    }
    
    /**
     * Divides the x, y and z of a SCNVector3 by the same scalar value.
     */
    static func /= ( vector: inout SCNVector3, scalar: CGFloat) {
        vector = vector / scalar
    }
}

public let SCNVector3One: SCNVector3 = SCNVector3(1.0, 1.0, 1.0)

func SCNVector3Uniform(_ value: CGFloat) -> SCNVector3 {
    return SCNVector3Make(value, value, value)
}


/**
 * Calculates the SCNVector from lerping between two SCNVector3 vectors
 */
func SCNVector3Lerp(vectorStart: SCNVector3, vectorEnd: SCNVector3, t: CGFloat) -> SCNVector3 {
    return SCNVector3Make(vectorStart.x + ((vectorEnd.x - vectorStart.x) * t), vectorStart.y + ((vectorEnd.y - vectorStart.y) * t), vectorStart.z + ((vectorEnd.z - vectorStart.z) * t))
}

/**
 * Project the vector, vectorToProject, onto the vector, projectionVector.
 */
func SCNVector3Project(vectorToProject: SCNVector3, projectionVector: SCNVector3) -> SCNVector3 {
    let scale: CGFloat = projectionVector.dot(vectorToProject) / projectionVector.dot(projectionVector)
    let v: SCNVector3 = projectionVector * scale
    return v
}

// Define a couple structures that hold GLFloats (3 and 2)
struct Float3 { var x, y, z: GLfloat }
struct Float2 { var s, t: GLfloat }

