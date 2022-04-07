//
//  User.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import Foundation
import FirebaseFirestoreSwift

struct UserOnlineFirebase: Codable, Identifiable{
    
    var id: String
    var username: String
    var is_online: Bool
    
    init(_id: String, _username: String, _isOnline: Bool){
        
        id = _id
        username = _username
        is_online = _isOnline
    }

    
}
