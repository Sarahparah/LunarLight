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
    
    func createUser(newUser: UserFirebase){
        
        do {
            _ = try dataBase.collection("users").addDocument(from: newUser)
        } catch {
            print("Error: Could not save user to Firestore")
        }
        
    }
    
    func updateUser(currentUser: UserFirebase) {
        
        let id = currentUser.id
        
        dataBase.collection("users").whereField("id", isEqualTo: id)
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
        dataBase.collection("users").addSnapshotListener { snapshot, error in
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
    
}



