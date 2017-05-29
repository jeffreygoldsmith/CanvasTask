//
//  Stochastic.swift
//  Canvas
//
//  Created by Jeffrey on 2017-05-15.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

//
// Function to choose a random rule for a given stochastic character
//
func randomSuccessor(successors: [String]) -> String
{
    var ruleProbabilities : [Int] = []  // Array of all successor probabilities
    var rules : [String] = []           // Array of parced rules
    var addativeArray : [Int] = []      //
    var max : Int = 0
    
    // Loop over successors to parce into probabilities and rules
    for successor in successors
    {
        let components = successor.components(separatedBy: "/") // Parce by "/"
        
        // If the rule is stochastic...
        if let probabilityOfRule = Int(components[0])
        {
            ruleProbabilities.append(probabilityOfRule) // Append probability
        }
        
        rules.append(components[1]) // Append rule
    }
    
    for probability in ruleProbabilities
    {
        max += probability // Create a maximum probability value
        addativeArray.append(max) // Append each max value to an array
    }
    
    let random = Int(arc4random_uniform(UInt32(max + 1))) // Create a random number to get the rule
    var index = 0
    
    for value in addativeArray
    {
        // If the current value is less than the random value we don't care
        if random <= value
        {
            break
        }
        
        index += 1 // Else add one to the index
    }
    
    return rules[index] // Return a randomized rule
}
