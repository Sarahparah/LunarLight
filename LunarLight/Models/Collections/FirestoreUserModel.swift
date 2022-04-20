//
//  FirestoreUserModel.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-06.
//

import Foundation
import Firebase

//Grundläggande userdata, här sparas all info om en user

class FirestoreUserModel: ObservableObject{
    
    let dataBase = Firestore.firestore()
    
    var users = [UserFirebase]()
    
    @Published var userFriends = [UserFirebase]()
    @Published var profileUser: UserFirebase?
    @Published var profileUserActive: Bool = false
    
    func createUser(newUser: UserFirebase){
        
        do {
            _ = try dataBase.collection(LocalData.USERS_COLLECTION_KEY).document(newUser.id).setData(from: newUser)
        } catch {
            print("Error: Could not save user to Firestore")
        }
    }
    
    
    
    func updateUser(currentUser: UserFirebase) {
        
        let id = currentUser.id
        
        dataBase.collection(LocalData.USERS_COLLECTION_KEY).whereField(LocalData.ID_DOCUMENT_KEY, isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    return
                }
                
                guard let document = querySnapshot!.documents.first else { return }
                document.reference.updateData([
                    LocalData.AVATAR_DOCUMENT_KEY: currentUser.avatar,
                    LocalData.PROFILE_INFO_DOCUMENT_KEY: currentUser.profile_info
                ])
            }
    }
    
    func getProfileUser(profileId: String) {
        
        print("fetching user profile...")
        
        dataBase.collection(LocalData.USERS_COLLECTION_KEY).whereField(LocalData.ID_DOCUMENT_KEY, isEqualTo: profileId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    return
                }
                
                guard let document = querySnapshot!.documents.first else { return }
                let result = Result {
                    try document.data(as: UserFirebase.self)
                }
                
                switch result {
                case .success(let item):
                    self.profileUser = item
                    self.profileUserActive = true
                    AppIndexManager.singletonObject.profileUser = item
                case .failure(let error):
                    print("User decode error: \(error)")
                }
            }
    }
    
    func listenToUsers() {
        
        //Read data once (example):
        //db.collection("tmp").getDocuments(completion: )
        
        //Add an async listener for database
        dataBase.collection(LocalData.USERS_COLLECTION_KEY).addSnapshotListener { snapshot, error in
            //print("Something was changed in database")
            guard let snapshot = snapshot else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.users.removeAll()
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: UserFirebase.self)
                }
                
                switch result {
                case .success(let item):
                    self.users.append(item)
                case .failure(let error):
                    print("User decode error: \(error)")
                }
            }
        }
    }
    
    func listenToUserFriends() {
        
        var friendsIds = [String]()
        
        for friend in AppIndexManager.singletonObject.firestoreFriendModel.friends {
            friendsIds.append(friend.id)
        }
        
        if friendsIds.isEmpty { return }
        
        //Add an async listener for database
        dataBase.collection(LocalData.USERS_COLLECTION_KEY).whereField(LocalData.ID_DOCUMENT_KEY, in: friendsIds).addSnapshotListener { snapshot, error in
            //print("Something was changed in database")
            guard let snapshot = snapshot else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.userFriends.removeAll()
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: UserFirebase.self)
                }
                
                switch result {
                case .success(let item):
                    self.userFriends.append(item)
                case .failure(let error):
                    print("User decode error: \(error)")
                }
            }
        }
    }
    
}



