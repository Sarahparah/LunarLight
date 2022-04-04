//
//  Chat.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import Foundation


class Chat: ObservableObject {
    
    
    @Published var entries = [ChatEntry]()
    
    init(){
        
        addMockData()
    }
    
    
    
    func updateEntry(entry: ChatEntry, with content: String?){
        
        if let index = entries.firstIndex(of: entry) {
            if let content = content {
                entries[index].name = content
            }
            
        }
    }
    
    
    
    
    
    func addMockData() {
        
        entries.append(ChatEntry(name: "Hampus", imageName: "person" ))
        entries.append(ChatEntry(name: "Daniel", imageName: "person"))
        entries.append(ChatEntry(name: "Karol", imageName: "person"))
        entries.append(ChatEntry(name: "Sarah", imageName: "person"))
        entries.append(ChatEntry(name: "Bill", imageName: "person"))
        
    }
    
}
