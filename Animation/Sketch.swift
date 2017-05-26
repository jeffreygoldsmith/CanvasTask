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
    let original : LindenmayerSystem
    let visualizedOriginal : VisualizedLindenmayerSystem
    let tumbleweed : LindenmayerSystem
    let visualizedTumbleweed : VisualizedLindenmayerSystem
//    let systems : [VisualizedLindenmayerSystem]
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 600, height: 600)
//        systems = parcer.parce()
        
        let tumbleweedRules = [Character("X") : ["X"], Character("F") : ["1XFF-[3-F+F+F]+[1+F-F-F]+FX"]]
        let tumbleweedColours = [1 : Colour(hue: 55, saturation: 74, brightness: 75), 2 : Colour(hue: 120, saturation: 70, brightness: 65), 3 : Colour(hue: 19, saturation: 39, brightness: 38)]
        
        tumbleweed = LindenmayerSystem(angle: 22, axiom: "FX", rules: tumbleweedRules, generations: 4)
        visualizedTumbleweed = VisualizedLindenmayerSystem(with: tumbleweed, length: 25, reduction: 1.5, x: 250, y: 200, thickness: 1, thicknessReduction: 1, direction: 90, colours: tumbleweedColours)
        
        let fooRules = [Character("X") : ["1/1XX", "1/1-XX", "1/1+XX"], Character("F") : ["F++[2FFFF]"]]
        original = LindenmayerSystem(angle: 10, axiom: "FX", rules: fooRules, generations: 6)
        visualizedOriginal = VisualizedLindenmayerSystem(with: original, length: 50, reduction: 1.5, x: 250, y: 200, thickness: 1, thicknessReduction: 1, direction: 180, colours: [1 : Colour(hue: 120, saturation: 60, brightness: 46), 2 : Colour(hue: 50, saturation: 9, brightness: 76)])
        
        
        visualizedTumbleweed.author = "Jeffrey Goldsmith"
        visualizedTumbleweed.description = "A circular tumbleweed like L-System"
        
        visualizedOriginal.author = "Jeffrey Goldsmith"
        visualizedOriginal.description = "A blue flower like L-System"
        
        parcer.writeSystems(path: "/Users/student/Desktop/test.txt", systems: [visualizedTumbleweed, visualizedOriginal])
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 350
        
//        canvas.render(system: visualizedOriginal, generation: 6)
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw()
    {
        // Render the current system
        
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }
    
}
