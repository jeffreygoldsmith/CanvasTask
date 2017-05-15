//
//  Rule.swift
//  Canvas
//
//  Created by Jeffrey on 2017-05-09.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

public struct Rule
{
    var letter : String
    var rule : String
    var percentage : Int
}

public struct LetterRule
{
    var letter : String
    var ruleNumber : Int
    var rules : [String : String] // Dictionary where key is a range (like 1...25) and value is the rule
}

extension LetterRule : Equatable
{
    public static func == (lhs: LetterRule, rhs: LetterRule) -> Bool {
        return lhs.letter == rhs.letter
    }
}

// Separate the rules by letter
// Create a percentage system that turns a number from 1-100 into an index
// For this use a lookup of some sort?
