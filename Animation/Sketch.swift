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
    let parcer = Parcer(path: "/Users/student/Desktop/test.txt")
    let systems : [VisualizedLindenmayerSystem]
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 600, height: 600)
        systems = parcer.parce()
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 240
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw()
    {
        // Render the current system
        canvas.renderAnimated(systems: systems, generations: [5])
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }
    
}
