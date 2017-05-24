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
        
        if (thickness == 0)
        {
            thickness = 1
            thicknessReduction = 1
        }
        
        let newSystem = LindenmayerSystem(angle: angle, axiom: axiom, rules: rules, generations: generations)
        let newVisualizedSystem = VisualizedLindenmayerSystem(with: newSystem, length: length, reduction: reduction, x: x, y: y, thickness: thickness, thicknessReduction: thicknessReduction, direction: direction, colours: colors)
        
        return newVisualizedSystem
    }
    
    
    func writeSystems(path: String, systems: [VisualizedLindenmayerSystem])
    {
        // Open an output file for writing, overwriting any existing data
        guard let writer = LineWriter(path: path, appending: false) else {
            print("Cannot open output file")
            exit(0); // cannot open output file
        }
        
        for system in systems
        {
            writer.write(line: "[")
            writer.write(line: "<")
            writer.write(line: "author:\(system.author)")
            writer.write(line: "description:\(system.description)")
            writer.write(line: "angle:\(Int(system.angle))")
            writer.write(line: "axiom:\(system.axiom)")
            
            writer.write(line: "rules:")
            writer.write(line: "{")
            for (character, rule) in system.rules
            {
                let individualRule = String(describing: rule).components(separatedBy: "\"")[1]
                writer.write(line: "\(character)=\(individualRule)")
            }
            writer.write(line: "}")
            
            writer.write(line: "generations:\(Int(system.n))")
            writer.write(line: ">")
            
            
            if (system.colours.count > 0)
            {
                writer.write(line: "colors:")
                writer.write(line: "{")
                for (number, colour) in system.colours
                {
                    writer.write(line: "\(number)=\(Int(colour.hue)),\(Int(colour.saturation)),\(Int(colour.brightness))")
                }
                writer.write(line: "}")
            }
            
            if (system.direction != nil)
            {
                writer.write(line: "direction:\(system.direction)")
            }
            
            writer.write(line: "length:\(Int(system.initialLength))")
            writer.write(line: "length_reduction:\(Int(system.reduction))")
            
            if (system.initialThickness != nil)
            {
                writer.write(line: "thickness:\(Int(system.initialThickness))")
                writer.write(line: "thickness_reduction:\(Int(system.thicknessReduction))")
            }
            
            if (system.x != nil)
            {
                writer.write(line: "x:\(Int(system.x))")
            }
            
            if (system.y != nil)
            {
                writer.write(line: "y:\(Int(system.y))")
            }
            
            writer.write(line: "]")
        }
        
        // Close the output file
        writer.close()
    }
}
