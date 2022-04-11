//
//  FirestorePrivateMsgModel.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import Firebase

class FirestorePrivateMsgModel: ObservableObject {
    
    let dataBase = Firestore.firestore()
    
    @Published var privateMsgs = [PrivateMsgFirebase]()

    func createPrivateMsg(newPrivateMsg: PrivateMsgFirebase, currentUserId: String, friendId: String) {
        
        do {
            _ = try dataBase.collection(LocalData.USERS_COLLECTION_KEY).document(currentUserId).collection(LocalData.FRIENDS_COLLECTION_KEY).document(friendId).collection(LocalData.PRIVATE_MESSAGES_COLLECTION_KEY).document(newPrivateMsg.id).setData(from: newPrivateMsg)
        } catch {
            print("Error: Could not save Private Message to Firebase")
        }
        
    }
    
}
