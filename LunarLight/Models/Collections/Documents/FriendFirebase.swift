//
//  FriendsFirebase.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import FirebaseFirestoreSwift

struct FriendFirebase: Codable, Identifiable, Equatable{
    
    var id: String
    var user_id: String
    
    init(_userId: String){
        
        id = UUID().uuidString
        user_id = _userId
    }
    
}
