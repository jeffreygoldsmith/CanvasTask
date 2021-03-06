import Foundation

public class EnhancedCanvas : Canvas {
    
    public func render(system s : VisualizedLindenmayerSystem) {
        
        render(system: s, generation: s.n)
        
    }
    
    public func render(system : VisualizedLindenmayerSystem, generation : Int) {
        
        // Verify that generation that was asked to be rendered actually exists
        var generation = generation
        if generation > system.n {
            generation = system.n
        }
        
        // Change the line length
        system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )
        
        // Render the word
        self.saveState()
        for c in system.word[generation].characters {
            interpret(character: c, forThis: system)
        }
        self.restoreState()

    }
    
    public func renderAnimated(systems : [VisualizedLindenmayerSystem], generations : [Int]) {
        
        for (i, system) in systems.enumerated()
        {
            // Verify that generation that was asked to be rendered actually exists
            var generation = generations.count > i ? generations[i] : generations[generations.count - 1]
            if generation > system.n {
                generation = system.n
            }
            
            // Things to do at start of L-system animation...
            if system.animationPosition == 0 {
                // Change the line length
                system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )
                system.currentThickness = Float( Double(system.initialThickness) / pow(Double(system.thicknessReduction), Double(generation)) )
            }
            
            // Don't run past end of the word
            if system.animationPosition < system.word[generation].characters.count {
                
                // Get the index of the next character
                let index = system.word[generation].index(system.word[generation].startIndex, offsetBy: system.animationPosition)
                
                // Get the next character
                let c = system.word[generation][index]
                
                // Render the character
                interpret(character: c, forThis: system)
                
                // Move to next character in word
                system.animationPosition += 1
            }
        }
    }
    
    func interpret(character : Character, forThis system : VisualizedLindenmayerSystem)
    {
        // Set the line colour and system thickness to the current values of the system
        self.lineColor = Color(hue: system.currentColour.hue, saturation: system.currentColour.saturation, brightness: system.currentColour.brightness, alpha: 100)
        self.defaultLineWidth = Int(system.currentThickness)
        
        let newX = Float(CGFloat(system.x) + cos(CGFloat(M_PI) * system.currentAngle/180) * CGFloat(system.currentLength))
        let newY = Float(CGFloat(system.y) + sin(CGFloat(M_PI) * system.currentAngle/180) * CGFloat(system.currentLength))
        
        if let characterAsInt = Int(String(character))
        {
            let currentColour = system.colours[characterAsInt]!
            system.currentColour = currentColour
            self.lineColor = Color(hue: currentColour.hue, saturation: currentColour.saturation, brightness: currentColour.brightness, alpha: 100)
            return
        }
        
        
        // Interpret each character of the word
        switch character {
        case "+":
            // Turn left
            system.currentAngle += system.angle
        case "-":
            // Turn right
            system.currentAngle -= system.angle
        case "[":
            system.stateStack.append(VisualizedLindenmayerSystem.systemState(xPos: system.x, yPos: system.y, angle: system.currentAngle))
        case "]":
            system.x = system.stateStack[system.stateStack.count - 1].xPos
            system.y = system.stateStack[system.stateStack.count - 1].yPos
            system.currentAngle = system.stateStack[system.stateStack.count - 1].angle
            system.stateStack.removeLast()
        case Character(String(character).uppercased()):
            // Go forward while drawing a line
            self.drawLine(fromX: system.x, fromY: system.y, toX: newX, toY: newY, lineWidth: Int(system.currentThickness))
            system.x = newX
            system.y = newY
        case Character(String(character).lowercased()):
            // Go forward without drawing a line
            system.x = newX
            system.y = newY
        default:
            // Do nothing for any another character in the word
            break
        }

    }
    
}
