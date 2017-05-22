//
//  Parcer.swift
//  Canvas
//
//  Created by Jeffrey on 2017-05-21.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation


public class Parcer
{
    let path : String
    
    init(path: String)
    {
        self.path = path
    }
    
    func parce() -> [VisualizedLindenmayerSystem]
    {
        // Open a file for reading and parse each line using the space character as a delimiter
        guard let reader = LineReader(path: path) else {
            print("Cannot open input file")
            exit(0); // cannot open file
        }
        
        // Create an empty array of type String
        var components : [String] = []
        var systems : [VisualizedLindenmayerSystem] = []
        
        // Process each line of the input file
        for (_, line) in reader.enumerated()
        {
            let splitLine = line.components(separatedBy: " ")
            // Check to see if we have reached the end of a system
            if (splitLine[0] == "]")
            {
                systems.append(parceSystem(data: components))
                components = []
            }
            // Build an array of each component from the file
            components.append(line)
        }
        
        return systems
    }
    
    func parceSystem(data: [String]) -> VisualizedLindenmayerSystem
    {
        var angle : Degrees = 0
        var axiom : String = ""
        var rules : [Character : [String]] = [:]
        var generations : Int = 0
        var colors : [Int : Colour] = [:]
        var direction : Int = 0
        var length : Float = 0
        var reduction : Float = 0
        var thickness : Float = 0
        var thicknessReduction : Float = 0
        var x : Float = 0
        var y : Float = 0
        
        for (index, value) in data.enumerated()
        {
            var trimmedValue = value.components(separatedBy: "\n")
            trimmedValue = trimmedValue[0].components(separatedBy: " ")
            let parcedValue = trimmedValue[0].components(separatedBy: ":")
            
            switch parcedValue[0] {
            case "angle":
                angle = Degrees(Int(parcedValue[1])!) // Set angle value
                break
            case "axiom":
                axiom = parcedValue[1] // Set axiom value
                break
            case "rules":
                var tempIndex = index + 2 // Create a new index and skip the opening "{"
                
                // Iterate over the rules and add them to the rules dictionary
                while (data[tempIndex].range(of: "}") == nil)
                {
                    var currentRule = data[tempIndex].components(separatedBy: "\n")
                    currentRule = currentRule[0].components(separatedBy: "=")
                    let currentCharacter = Character(currentRule[0])
                    
                    if (rules[currentCharacter] == nil)
                    {
                        rules[currentCharacter] = []
                    }
                    
                    rules[currentCharacter]?.append(currentRule[1])
                    tempIndex += 1
                }
                
                break
            case "generations":
                generations = Int(parcedValue[1])! // Set generations value
            case "colors":
                var tempIndex = index + 2 // Create a new index and skip the opening "{"
                
                // Iterate over the colours and add them to the colours dictionary
                while (data[tempIndex].range(of: "}") == nil)
                {
                    var currentUnparcedColour = data[tempIndex].components(separatedBy: "\n")
                    currentUnparcedColour = currentUnparcedColour[0].components(separatedBy: "=")
                    
                    let identifier = Int(currentUnparcedColour[0])
                    let colourValues = currentUnparcedColour[1].components(separatedBy: ",")
                    
                    let h = Float(colourValues[0])!
                    let s = Float(colourValues[1])!
                    let b = Float(colourValues[2])!
                    colors[identifier!] = Colour(hue: h, saturation: s, brightness: b)
                    
                    tempIndex += 1
                }
                
                break
            case "direction":
                direction = Int(parcedValue[1])! // Set direction
                break
            case "length":
                length = Float(parcedValue[1])! // Set length
                break
            case "length_reduction":
                reduction = Float(parcedValue[1])! // Set reduction value
                break
            case "thickness":
                thickness = Float(parcedValue[1])! // Set thickness value
                break
            case "thickness_reduction":
                thicknessReduction = Float(parcedValue[1])! // Set thickness reduction value
                break
            case "x":
                x = Float(parcedValue[1])! // Set x value
                break
            case "y":
                y = Float(parcedValue[1])! // Set y value
                break
            default:
                break
            }
        }
        
        let newSystem = LindenmayerSystem(angle: angle, axiom: axiom, rules: rules, generations: generations)
        let newVisualizedSystem = VisualizedLindenmayerSystem(with: newSystem, length: length, reduction: reduction, x: x, y: y, thickness: thickness, thicknessReduction: thicknessReduction, direction: direction, color: colors)
        
        return newVisualizedSystem
    }
}
