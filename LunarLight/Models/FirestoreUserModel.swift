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
    
    func createUser(newUser: UserFirebase){
        
        do {
            _ = try dataBase.collection("users").addDocument(from: newUser)
        } catch {
            print("Error: Could not save user to Firestore")
        }
        
    }
}



