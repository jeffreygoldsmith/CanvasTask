import Foundation

public class LindenmayerSystem {
    // Set up required information
    var angle : Degrees                 // rotation amount for turtle (degrees)
    var axiom : String
    var rules : [Character : [String]]
    var n : Int                         // number of times the production rule is applied
    var word : [String] = []            // the word that will be rendered
    // is rendered with an animation, step by step
    
    public init(angle : Degrees,
                axiom : String,
                rules : [Character : [String]],
                generations : Int) {
        
        // Initialize stored properties
        self.angle = angle
        self.axiom = axiom
        self.rules = rules
        self.n = generations
        self.word.append(axiom)   // The first word is the axiom
        
//        var ruleCount = 0 // Number of rules for a specific letter
//        var currentLetter = "" // Current letter
//        var previousLetter = rules[0].letter // Previous letter
//        
//        for (index, rule) in rules.enumerated()
//        {
//            print(index, rule)
//            currentLetter = rule.letter
//            ruleCount += 1 // Add to the rule count
//            
//            // If we have moved onto another letter
//            if (currentLetter != previousLetter || index == rules.count - 1)
//            {
//                // Create the new element to be added to the rule set
//                let percentageUnit = 100 / ruleCount
//                var currentPercentage = 0
//                var tempLookup : [String : String] = [:]
//                
//                // Iterate over the rules that we have just looked at
//                for i in index...index + ruleCount
//                {
//                    print(i)
//                    let rulePercentage = rules[i - 1].percentage * percentageUnit // Calculate the percentage of the rule out of 100
//                    let key = "\(currentPercentage),\(currentPercentage + rulePercentage)" // Create the key for the new element
//                    tempLookup[key] = rules[i - 1].rule // Add the element to the temporary array to be added to ruleSet
//                    
//                    currentPercentage += rulePercentage // Advance the current percentage
//                }
//                
//                let newRule = LetterRule(letter: previousLetter, ruleNumber: ruleCount, rules: tempLookup) // Create the full new rule
//                ruleSet.append(newRule) // Append that to ruleSet
//                
//                ruleCount = 0 // Reset the count
//            }
//            previousLetter = currentLetter
//        }
//        
//        print(ruleSet)
        
        // Apply the production rule
        applyRules()
        
    }
    
    public init(with system : LindenmayerSystem) {
        
        // Initalize stored properties
        self.angle = system.angle
        self.axiom = system.axiom
        self.rules = system.rules
        self.n = system.n
        self.word.append(axiom)   // The first word is the axiom
        
        // Apply the production rule
        self.applyRules()
    }
    
    func applyRules() {
        
        // See if word needs to be re-written
        if n > 0 {
            
            // Apply the production rule "n" times
            for i in 1...n {
                
                // Create a new word
                var newWord = ""
                
                // Inspect each character of existing word
                for character in word[i - 1].characters {
                    
                    if (character != "+" && character != "-" && Int(String(character)) == nil)
                    {
                        if let successors = rules[character]
                        {
                            if successors.count > 1
                            {
                                let ruleToAppend = randomSuccessor(successors: successors)
                                newWord.append(ruleToAppend)
                            } else {
                                newWord.append(successors[0])
                            }
                        }
                    } else {
                        newWord.append(character) // just copy what's in the existing word to the new word
                    }
                    
                }
                
                // Add the re-written word to the system
                word.append(newWord)
                
            }
            
        }
        
    }
    
}
