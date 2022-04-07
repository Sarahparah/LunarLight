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
    var username: String
    var message: String
    var timestamp: Double
    
    init(_id: String, _username: String, _message: String){
        
        id = _id
        username = _username
        message = _message
        timestamp = NSDate().timeIntervalSince1970
    }
    
}
