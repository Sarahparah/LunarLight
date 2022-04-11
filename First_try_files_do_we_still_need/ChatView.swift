//
//  ChatView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct ChatView: View {
    
    var entry: ChatEntry? = nil
    let defaultContent = "Enter text..."
    
    
    
    @EnvironmentObject var chat : Chat
    @Environment(\.presentationMode) var presentationMode
    
    @State var content: String = ""
    
    var body: some View {
        
        VStack{
            TextEditor(text: $content)
                .onTapGesture {
                    clearText()
                }
            
        }.navigationBarItems(trailing: Button(action: {
            //saveEntry()
            presentationMode.wrappedValue.dismiss()
            
        } ,label: { Text("save") }))
            .onAppear(perform: setContent)
    }
    
    func clearText() {
        
        if entry == nil{
            content = ""
        }
        
    }
    
    func setContent(){
        
        //        guard  let entry = entry else {return}
        
        if let entry = entry{
            
            
            content = entry.name
        } else {
            content = defaultContent
            
        }
    }
    
    
    //    func saveEntry() {
    //
    //        if let entry = entry {
    //            //uppdatera befintlig entry
    //            chat.updateEntry(entry: entry, with: content)
    //
    //
    //        } else {
    //            //skapa en ny entry
    //            let newEntry = ChatEntry(content: content, imageName: )
    //            chat.entries.append(newEntry)
    //        }
    //        
    //    }
    
}
