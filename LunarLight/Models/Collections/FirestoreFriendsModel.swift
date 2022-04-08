//
//  FirestoreFriendsModel.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import Firebase

class FirestoreFriendsModel: ObservableObject{
    
    let dataBase = Firestore.firestore()
    
    @Published var friends = [FriendsFirebase]()
    
    func createFriend(newFriend: FriendsFirebase) {
        
        
        let id = AppIndexManager.singletonObject.currentUser.id
        
        
        
        //let currentUser = AppIndexManager.singletonObject.currentUser
        
        
        
    }
}

