//
//  User.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-06.
//

import Foundation
import FirebaseFirestoreSwift

struct UserFirebase: Codable, Identifiable{
    
    var id: String
    var username: String
    var email: String
    var password: String
    var year: UInt64
    var month: UInt64
    var day: UInt64
    var avatar: String
    var profile_info: String
    
    init(_id: String = "", _username: String, _email: String, _password: String, _year: UInt64, _month: UInt64, _day: UInt64, _avatar: String, _profileInfo: String ){
        
        id = _id
        username = _username
        email = _email
        password = _password
        year = _year
        month = _month
        day = _day
        avatar = _avatar
        profile_info = _profileInfo
    }
    
}
