//
//  Encryption.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-19.
//

import Foundation

class Encryption {
    
    //function to generate a token (encrypted string) from user input
    func getToken(input: String) -> String {
        
        var token = ""
        
        var i = 0
        for char in input {
            
            //get ascii value for current char
            var asciiValue: UInt8 = char.asciiValue ?? UInt8(32)
            
            //if asciivalue is lower than UInt8.max, increase with 1
            if asciiValue < UInt8.max {
                asciiValue += UInt8(i)
            }
            
            //if asciiValue is greater than 255, remove 255 from value
            if asciiValue > 255 {
                asciiValue -= 255
            }
            //if asciiValue is lower than 32, add 32 to the value
            if asciiValue < 32 {
                asciiValue += 32
            }
            
            //on even indexes: append the asciiValue
            if i % 2 == 0 {
                token += "\(asciiValue)"
            }
            //on un-even indexes: apply the new char
            else {
                token += String(UnicodeScalar(asciiValue))
            }
            
            print("DanneToken: \(i) = \(token)")
            
            i += i
        }
        
        //finally return the encrypted string
        return token
    }
    
}
