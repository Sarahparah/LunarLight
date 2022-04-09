//
//  InputValidator.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation

class InputValidator {
    
    func isValidEmail(_ email: String) -> Bool {
        
        //validate email format
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let formatValid = emailPred.evaluate(with: email)
        if !formatValid {
            return false
        }
        return true
    }
    
    func isValidUsername(_ username: String) -> Bool {
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789")
        if username.rangeOfCharacter(from: characterset.inverted) != nil {
            return false
        }
        return true
    }
}
