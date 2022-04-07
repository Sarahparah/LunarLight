//
//  WorldMsgFirebase.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import Foundation
import FirebaseFirestoreSwift

struct WorldMsgFirebase: Codable, Identifiable{
    
    var id: String
    var userId: String
    var username: String
    var message: String
    var timestamp: Double
    
    init(_userId: String, _username: String, _message: String){
        
        id = UUID().uuidString
        userId = _userId
        username = _username
        message = _message
        timestamp = NSDate().timeIntervalSince1970
    }
    
}
