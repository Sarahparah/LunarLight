//
//  PrivateMsgFirebase.swift
//  LunarLight
//
//  Created by Hampus Brandtman on 2022-04-08.
//

import Foundation
import FirebaseFirestoreSwift

struct PrivateMsgFirebase: Codable, Identifiable, Equatable{
    
    var id: String
    var my_message: String
    var timestamp: Double
    
    init( _message: String){
        
        id = UUID().uuidString
        my_message = _message
        timestamp = NSDate().timeIntervalSince1970
    }
    
}
