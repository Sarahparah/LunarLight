//
//  ChatEntry.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import Foundation



struct ChatEntry: Identifiable, Equatable {
    
    var id =  UUID()
    
    var content: String
    var date: Date = Date()
    
    
    
    
    
}
