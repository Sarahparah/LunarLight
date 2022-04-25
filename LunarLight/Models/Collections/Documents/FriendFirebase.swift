//
//  FriendsFirebase.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import FirebaseFirestoreSwift

struct FriendFirebase: Codable, Identifiable, Equatable{
    
    // codable använder vi för att konvertera vår swiftdata till databasDATA
    
    var id: String
    
    init(_userId: String){
        
        id = _userId
    }
    
}
