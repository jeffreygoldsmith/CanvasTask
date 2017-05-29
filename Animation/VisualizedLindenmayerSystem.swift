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
    
    var author : String = ""                // Author of system
    var description : String = ""           // Short description of system
    var initialLength : Float               // Initial line segment length
    var initialThickness : Float            // Initial line segment width
    var reduction : Float                   // Reduction factor
    var x : Float                           // Initial horizontal position of turtle
    var y : Float                           // Initial vertical position of turtle
    var direction : Int                     // Initial direction turtle faces (degrees)
    var currentLength : Float               // Current line segment length
    var currentThickness : Float            // Current line thickness
    var currentColour : Colour              // Current line colour
    var thicknessReduction : Float          // System thickness reduction factor
    var animationPosition = 0               // Current character being drawn
    var currentAngle : Degrees              // Current angle of system
    var stateStack = [systemState]()        // Stack of systemStates to keep track of systems
    var colours : [Int : Colour]            // Colours for the system

    public init(with providedSystem: LindenmayerSystem,
                length: Float,
                reduction: Float,
                x: Float,
                y: Float,
                thickness : Float,
                thicknessReduction : Float,
                direction: Int,
                colours: [Int : Colour]) {
        
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
        self.currentColour = Colour(hue: 0, saturation: 0, brightness: 0)
        self.currentAngle = Degrees(direction)
        self.colours = colours
        
        super.init(with: providedSystem)
        
    }
    

}
