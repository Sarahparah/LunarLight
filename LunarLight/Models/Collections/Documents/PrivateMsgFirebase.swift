//
//  PrivateMsgFirebase.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import FirebaseFirestoreSwift

struct PrivateMsgFirebase: Codable, Identifiable, Equatable, Hashable{
    
    var id: String
    var sender_id: String
    var receiver_id: String
    var my_message: String
    var timestamp: UInt64
    
    init( _message: String, _senderId: String, _receiverId: String){
        
        id = UUID().uuidString
        sender_id = _senderId
        receiver_id = _receiverId
        my_message = _message
        timestamp = UInt64(NSDate().timeIntervalSince1970*1000)
    }
    
}
