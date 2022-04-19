//
//  WorldMsgFirebase.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import Foundation
import FirebaseFirestoreSwift

struct WorldMsgFirebase: Codable, Identifiable, Equatable, Hashable{
    
    var id: String
    var user_id: String
    var username: String
    var avatar: String
    var message: String
    var timestamp: UInt64
    var month: UInt64
    var day: UInt64
    
    init(_userId: String, _username: String, _message: String, _avatar: String, _month: UInt64, _day: UInt64){
        
        id = UUID().uuidString
        month = _month
        day = _day
        user_id = _userId
        avatar = _avatar
        username = _username
        message = _message
        timestamp = UInt64(NSDate().timeIntervalSince1970*1000)
    }
    
}
