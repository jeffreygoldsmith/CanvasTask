//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : EnhancedCanvas
    
    // Create the basic L-systems
    let kochSnowflake : LindenmayerSystem
    
    // Create the visualizations of the snowflake
    let mediumKochSnowflake : VisualizedLindenmayerSystem
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 500, height: 500)
        
        let blue = Colour(hue: 240, saturation: 80, brightness: 90)
        
        let rules = [Character("X") : ["F-[[X]+X]+F[+FX]-X"], Character("F") : ["FF"]]
        
        // Set up a Koch snowflake
        kochSnowflake = LindenmayerSystem(angle: 25,
                                          axiom: "X",
                                          rules: rules,
                                          generations: 6)
        
        // Visualize this as a small snowflake
        mediumKochSnowflake = VisualizedLindenmayerSystem(with: kochSnowflake,
                                                          length: 150,
                                                          reduction: 2,
                                                          x: 300,
                                                          y: 50,
                                                          direction: 90,
                                                          color: [1 : blue])
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 240
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
        
        // Render the current system
        canvas.renderAnimated(system: mediumKochSnowflake, generation: 6)
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }
    
}
