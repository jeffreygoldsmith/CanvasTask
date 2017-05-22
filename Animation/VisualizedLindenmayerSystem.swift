//
//  VisualizedLindenmayerSystem.swift
//  Canvas
//
//  Created by Russell Gordon on 5/3/17.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

public class VisualizedLindenmayerSystem : LindenmayerSystem {
    
    public struct systemState {
        var xPos : Float
        var yPos : Float
        var angle : Degrees
    }
    
    var initialLength : Float               // initial line segment length
    var initialThickness : Float               // initial line segment width
    var reduction : Float                   // reduction factor
    var x : Float                             // initial horizontal position of turtle
    var y : Float                             // initial vertical position of turtle
    var direction : Int                     // initial direction turtle faces (degrees)
    var currentLength : Float               // current line segment length
    var currentThickness : Float
    var thicknessReduction : Float
    var animationPosition = 0               // tracks current character being interpreted when system is animated
    var currentAngle : Degrees
    var stateStack = [systemState]()
    var color : [Int : Colour]

    public init(with providedSystem: LindenmayerSystem,
                length: Float,
                reduction: Float,
                x: Float,
                y: Float,
                thickness : Float,
                thicknessReduction : Float,
                direction: Int,
                color: [Int : Colour]) {
        
        // Initialize stored properties
        self.initialLength = length
        self.initialThickness = thickness
        self.reduction = reduction
        self.x = x
        self.y = y
        self.direction = direction
        self.currentThickness = self.initialThickness
        self.thicknessReduction = thicknessReduction
        self.currentLength = self.initialLength
        self.currentAngle = Degrees(direction)
        self.color = color
        
        super.init(with: providedSystem)
        
    }
    

}
