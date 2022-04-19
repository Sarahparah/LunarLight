//
//  FirestoreLobbyMessageModel.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import Foundation
import Firebase

class FirestoreWorldMsgModel: ObservableObject{
    
    let dataBase = Firestore.firestore()
    
    @Published var worldMessages = [WorldMsgFirebase]()
    
    func createMessage(newMessage: WorldMsgFirebase) {
        
        print(newMessage.message)
        
        do {
            _ = try dataBase.collection(LocalData.WORLD_MESSAGES_COLLECTION_KEY).document(newMessage.id).setData(from: newMessage)
        } catch {
            print("Error: Could not save world message to Firestore")
        }
    }
    
    func listenToWorldMessages() {
        
        //Read data once (example):
        //db.collection("tmp").getDocuments(completion: )
        
        //Add an async listener for database
        dataBase.collection(LocalData.WORLD_MESSAGES_COLLECTION_KEY).order(by: LocalData.TIMESTAMP_DOCUMENT_KEY, descending: false).addSnapshotListener { snapshot, error in
            //print("Something was changed in database")
            guard let snapshot = snapshot else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.worldMessages.removeAll()
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: WorldMsgFirebase.self)
                }
                
                switch result {
                case .success(let item):
                    self.worldMessages.append(item)
                case .failure(let error):
                    print("User decode error: \(error)")
                }
            }
        }
    }
}
