//
//  LobbyChatView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI


struct LobbyChatView: View {
    
    
    @StateObject var chat = Chat()
    @State var showInfo : Bool = false
    
    var body: some View {
        
        VStack{
            NavigationView{
                List{
                    ForEach(chat.entries){ entry in
                        
                        NavigationLink(destination: ChatView(entry: entry)){
                            TitleRow(image: Image(systemName: entry.imageName), name: entry.name)
                        }
                        .onAppear(perform: { print(entry.date)})
                        
                    }.onDelete(perform: { indexSet in
                        print ("delete")
                        chat.entries.remove(atOffsets: indexSet)
                        
                    })
                    
                }
            }
            Spacer()
        }
    }
}





struct LobbyChatView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyChatView()
    }
}
