//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch : NSObject
{
    let canvas : EnhancedCanvas
    let parcer = Parcer()
    var systems : [VisualizedLindenmayerSystem]
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 600, height: 600)
        
        systems = []
        let whichSystem = "stochastic"
        let gradient = Gradient(on: canvas)
        gradient.makeGradient(lowerLeftX: 250, lowerLeftY: 250, from: 160, to: 180) // Draw sky
        
        // Compare the whichSystem string to find which file to read from to create the scene
        if (whichSystem == "stochastic")
        {
            systems = parcer.parce(path: "/User/student/Desktop/stochastic.txt") // Parce the file
            canvas.fillColor = Color(hue: 36, saturation: 92, brightness: 20, alpha: 100) // Dirt
        } else if (whichSystem == "deterministic")
        {
            systems = parcer.parce(path: "/User/student/Desktop/deterministic.txt") // Parce the file
            canvas.fillColor = Color(hue: 68, saturation: 55, brightness: 78, alpha: 100) // Sand
        }
        
        canvas.drawRectangle(bottomLeftX: 0, bottomLeftY: 0, width: 600, height: 250) // Draw the ground rectangle
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 120
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw()
    {
        // Render the current system
        canvas.renderAnimated(systems: systems, generations: [5]) // Render systems
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }
    
}
