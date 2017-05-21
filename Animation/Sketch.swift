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
    let tree : LindenmayerSystem
    let triangle : LindenmayerSystem
    
    // Create the visualizations of the snowflake
    let systemOne : VisualizedLindenmayerSystem
    let systemTwo : VisualizedLindenmayerSystem
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 500, height: 500)
        
        let blue = Colour(hue: 240, saturation: 80, brightness: 90)
        
        let rules = [Character("X") : ["F-[[X]+X]+F[+FX]-X"], Character("F") : ["FF"]]
        let rules2 = [Character("F") : ["F-G+F+G-F"], Character("G") : ["GG"]]
        
        // Set up a Koch snowflake
        tree = LindenmayerSystem(angle: 25,
                                          axiom: "X",
                                          rules: rules,
                                          generations: 6)
        
        triangle = LindenmayerSystem(angle: 120,
                                 axiom: "F-G-G",
                                 rules: rules2,
                                 generations: 4)
        
        // Visualize this as a small snowflake
        systemOne = VisualizedLindenmayerSystem(with: tree,
                                                          length: 150,
                                                          reduction: 2,
                                                          x: 150,
                                                          y: 50,
                                                          direction: 90,
                                                          color: [1 : blue])
        
        systemTwo = VisualizedLindenmayerSystem(with: triangle,
                                                length: 150,
                                                reduction: 2,
                                                x: 350,
                                                y: 200,
                                                direction: 90,
                                                color: [1 : blue])
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 240
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
        
        // Render the current system
        canvas.renderAnimated(systems: [systemOne, systemTwo], generations: [6, 4])
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }
    
}
