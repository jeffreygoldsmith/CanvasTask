//
//  Stochastic.swift
//  Canvas
//
//  Created by Jeffrey on 2017-05-15.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

func randomSuccessor(successors: [String]) -> String
{
    var ruleProbabilities : [Int] = [] // Array of all successor probabilities
    var rules : [String] = []
    var addativeArray : [Int] = [] //
    var max : Int = 0
    
    for successor in successors
    {
        let components = successor.components(separatedBy: "/")
        
        if let probabilityOfRule = Int(components[0])
        {
            ruleProbabilities.append(probabilityOfRule)
        }
        rules.append(components[1])
    }
    
    for i in ruleProbabilities
    {
        max += i
        addativeArray.append(max)
    }
    
    let random = Int(arc4random_uniform(UInt32(max + 1)))
    var c = 0
    
    for i in addativeArray
    {
        
        if random <= i
        {
            break
        }
        
        c += 1
    }
    
    print(rules)
    print(rules[c])
    return rules[c]
}
