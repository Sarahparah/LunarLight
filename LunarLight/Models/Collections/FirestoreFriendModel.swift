//
//  FirestoreFriendsModel.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import Firebase

class FirestoreFriendModel: ObservableObject{
    
    let dataBase = Firestore.firestore()
    
    var friends = [FriendFirebase]()
    
    func createFriend(newFriend: FriendFirebase) {
        
        let id = AppManager.singletonObject.loggedInUser.id
        
        // letar upp vald user och lägger till i sin egen Friend Collection baserat på ID.
        
        do {
            _ = try dataBase.collection(LocalData.USERS_COLLECTION_KEY).document(id).collection(LocalData.FRIENDS_COLLECTION_KEY).document(newFriend.id).setData(from: newFriend)
        } catch {
            print("Error: Could not save user to Firestore")
        }
        //let currentUser = AppIndexManager.singletonObject.currentUser
    }
    
    func listenToFriends() {
        
        //Read data once (example):
        //db.collection("tmp").getDocuments(completion: )
        
        let userId = AppManager.singletonObject.loggedInUser.id
        
        //Add an async listener for database
        dataBase.collection(LocalData.USERS_COLLECTION_KEY).document(userId).collection(LocalData.FRIENDS_COLLECTION_KEY).addSnapshotListener { snapshot, error in
            //print("Something was changed in database")
            guard let snapshot = snapshot else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.friends.removeAll()
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: FriendFirebase.self)
                }
                
                switch result {
                case .success(let item):
                    self.friends.append(item)
                case .failure(let error):
                    print("User decode error: \(error)")
                }
            }
        }
    }
}


