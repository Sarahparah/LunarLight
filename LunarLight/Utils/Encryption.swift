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
        for char in Array(input) {
            
            //get ascii value for current char
            let asciiValue: UInt = UInt(char.asciiValue ?? UInt8(32))
            
            if i % 3 == 0 {
                print("DanneToken 1")
                token += String(asciiValue * 2)
            }
            else if i % 2 == 0 {
                print("DanneToken 2")
                token += String(asciiValue * 3)
            }
            else {
                print("DanneToken 3")
                token += "_\(asciiValue)"
            }
            
            i += 1
        }
        
        //finally return the encrypted string
        return token
    }
    
}
