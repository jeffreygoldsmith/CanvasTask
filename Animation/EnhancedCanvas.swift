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
//        self.translate(byX: system.x, byY: system.y) // Move turtle to starting point
        for c in system.word[generation].characters {
            interpret(character: c, forThis: system)
        }
        self.restoreState()

    }
    
    public func renderAnimated(system : VisualizedLindenmayerSystem, generation : Int) {
        
        // Verify that generation that was asked to be rendered actually exists
        var generation = generation
        if generation > system.n {
            generation = system.n
        }
        
        // Things to do at start of L-system animation...
        if system.animationPosition == 0 {
            
            // Change the line length
            system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )

            // Move turtle to starting point
//            self.translate(byX: system.x, byY: system.y) // Move turtle to starting point
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
    
    func interpret(character : Character, forThis system : VisualizedLindenmayerSystem)
    {
        
        let newX = Float(CGFloat(system.x) + cos(CGFloat(M_PI) * system.currentAngle/180) * CGFloat(system.currentLength))
        let newY = Float(CGFloat(system.y) + sin(CGFloat(M_PI) * system.currentAngle/180) * CGFloat(system.currentLength))
        
        if let characterAsInt = Int(String(character))
        {
            let currentColour = system.color[characterAsInt]!
            self.lineColor = Color(hue: currentColour.hue, saturation: currentColour.saturation, brightness: currentColour.brightness, alpha: 100)
            return
        }
        
        let uppercase = try! NSRegularExpression(pattern:"[A-Z]", options: NSRegularExpression.Options(rawValue: 0))
        let lowercase = try! NSRegularExpression(pattern:"[a-z]", options: NSRegularExpression.Options(rawValue: 0))
        let string = String(character)
        let nsstring = string as NSString?
        let isUppercase = uppercase.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.characters.count))
        let isLowercase = lowercase.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.characters.count))
        
        // Interpret each character of the word
        switch character {
        case "+":
            // Turn left
            system.currentAngle += system.angle
        case "-":
            // Turn right
            system.currentAngle -= system.angle
        case "[":
            print(system.x, system.y, system.currentAngle)
            system.stateStack.append(VisualizedLindenmayerSystem.systemState(xPos: system.x, yPos: system.y, angle: system.currentAngle))
        case "]":
            system.x = system.stateStack[system.stateStack.count - 1].xPos
            system.y = system.stateStack[system.stateStack.count - 1].yPos
            system.currentAngle = system.stateStack[system.stateStack.count - 1].angle
            
            print(system.x, system.y, system.currentAngle)
            system.stateStack.removeLast()
        case Character(isUppercase.map { nsstring?.substring(with: $0.range)}!!):
            // Go forward while drawing a line
            self.drawLine(fromX: system.x, fromY: system.y, toX: newX, toY: newY)
            system.x = newX
            system.y = newY
        case Character(isLowercase.map { nsstring?.substring(with: $0.range)}!!):
            print(isLowercase!)
            // Go forward without drawing a line
            system.x = newX
            system.y = newY
        default:
            // Do nothing for any another character in the word
            break
        }

    }
    
}
