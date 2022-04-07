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
        
        do {
            _ = try dataBase.collection(LocalData.WORLD_MESSAGES_COLLECTION_KEY).addDocument(from: newMessage)
        } catch {
            print("Error: Could not save world message to Firestore")
        }
        
    }
    
    
    
}
