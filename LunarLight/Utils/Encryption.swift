//
//  Encryption.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-19.
//

import Foundation

class Encryption {
    
    //Get encrypted password (token) by http get request from PHP API
    func getTokenByHttpRequest(input: String) async throws -> String {
        guard let url = URL(string: "https://lunarlightkyh.000webhostapp.com/?password=\(input)") else { fatalError("error") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let responseCode = (response as? HTTPURLResponse)?.statusCode else { fatalError("error") }
        
        if responseCode < 200 || responseCode > 299 {
            fatalError("error")
        }

        let token = String(data: data, encoding: .utf8)!
        
        print("DanneToken = \(token)")
        
        return token
    }
    
    //Self written encryption: Currently not used (replaced by getTokenByHttpRequest()-method)
    //function to generate a token (encrypted string) from user input
    func getToken(input: String) -> String {
        
        var token = ""
        
        var shuffledInput = Array(input)
        
        //shuffle input chars
        var n = 0
        for _ in stride(from: 0, to: shuffledInput.count-2, by: 2) {
            let char1 = shuffledInput[n]
            let char2 = shuffledInput[n+1]
            
            shuffledInput[n] = char2
            shuffledInput[n+1] = char1
            
            n += 2
        }
        
        var i = 0
        for char in shuffledInput {
            
            //get ascii value for current char
            var asciiValue: Int = Int(char.asciiValue ?? UInt8(32))
            
            //change ascii value based on modulus
            if i % 3 == 0 {
                asciiValue = Int(Double(asciiValue) * 1.1)
            }
            else if i % 2 == 0{
                asciiValue = Int(Double(asciiValue) * 1.2)
            }
            else {
                asciiValue = Int(Double(asciiValue) * 0.9)
            }
            
            //secure that all chars are within range 32...127
            while asciiValue > 127 {
                asciiValue -= 127
            }
            while asciiValue < 32 {
                asciiValue += 32
            }
            
            if i % 3 == 0 {
                token += String(UnicodeScalar(UInt8(asciiValue)))
            }
            else if i % 2 == 0 {
                token += String(UnicodeScalar(UInt8(asciiValue)))
            }
            else {
                token += String(asciiValue * 19)
            }
            
            i += 1
        }
        
        //finally return the encrypted string
        return token
    }
    
}
