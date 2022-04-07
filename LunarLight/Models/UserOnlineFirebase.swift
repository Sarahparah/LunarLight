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
    var isOnline: Bool
    
    init(_id: String, _isOnline: Bool){
        
        id = _id
        isOnline = _isOnline
    }

    
}
