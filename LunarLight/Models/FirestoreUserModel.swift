//
//  FirestoreUserModel.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-06.
//

import Foundation
import Firebase

class FirestoreUserModel: ObservableObject{
    
    let dataBase = Firestore.firestore()
    
    var users = [UserFirebase]()
    @Published var usersOnline = [UserOnlineFirebase]()
    
    func createUser(newUser: UserFirebase){
        
        let userOnline = UserOnlineFirebase(_id: newUser.id, _username: newUser.username, _isOnline: true)
        
        do {
            _ = try dataBase.collection(LocalData.USERS_COLLECTION_KEY).addDocument(from: newUser)
            _ = try dataBase.collection(LocalData.USERS_ONLINE_COLLECTION_KEY).addDocument(from: userOnline)
        } catch {
            print("Error: Could not save user to Firestore")
        }
        
    }
    
    func updateUser(currentUser: UserFirebase) {
        
        let id = currentUser.id
        
        dataBase.collection(LocalData.USERS_COLLECTION_KEY).whereField("id", isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    return
                }
                
                guard let document = querySnapshot!.documents.first else { return }
                document.reference.updateData([
                    "avatar": currentUser.avatar
                ])
                
            }
        
    }
    
    func listenToFirestore() {
        
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
    
    func updateOnlineUser(currentUserOnline: UserOnlineFirebase) {
        
        let id = currentUserOnline.id
        
        dataBase.collection(LocalData.USERS_ONLINE_COLLECTION_KEY).whereField("id", isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    return
                }
                
                guard let document = querySnapshot!.documents.first else { return }
                document.reference.updateData([
                    "is_online": currentUserOnline.is_online
                ])
                
            }
        
    }
    
    func listenToOnlineUsers() {
        
        //Read data once (example):
        //db.collection("tmp").getDocuments(completion: )
        
        //Add an async listener for database
        dataBase.collection(LocalData.USERS_ONLINE_COLLECTION_KEY).addSnapshotListener { snapshot, error in
            //print("Something was changed in database")
            guard let snapshot = snapshot else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.usersOnline.removeAll()
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: UserOnlineFirebase.self)
                }
                
                switch result {
                case .success(let item):
                    if item.id == AppIndexManager.singletonObject.currentUser.id {
                        continue
                    }
                    if item.is_online {
                        self.usersOnline.append(item)
                    }
                case .failure(let error):
                    print("User decode error: \(error)")
                }
                
            }
            
            print("Users online: \(self.usersOnline.count)")
        }
    }
    
}



