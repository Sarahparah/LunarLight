//
//  User.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-06.
//

import Foundation
import FirebaseFirestoreSwift

struct UserFirebase: Codable, Identifiable{
    
    var id: String = UUID().uuidString
    var username: String
    var email: String
    var password: String
    var year: UInt64
    var month: UInt64
    
    init(_username: String, _email: String, _password: String, _year: UInt64, _month: UInt64 ){
        
        
        username = _username
        email = _email
        password = _password
        year = _year
        month = _month
    }
    
}
