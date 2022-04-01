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
//        NavigationView {
            VStack{
                
                VStack{
                    
                    Text("Lunar Light")
                        .font(.title)
                        .foregroundColor(.purple)
                    Button {
                        AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                    } label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                            Text( "Lobby")
                            Spacer()
                        }
                        
                    }.padding()
                    Spacer()
                    
                }
                
            }
            
            
            List(){
                
                
                
                ForEach(chat.entries){ entry in
                    
                    NavigationLink(destination: ChatView(entry: entry)){
                        Text(entry.content)

                    }
                    .onAppear(perform: { print(entry.date)})

                }.onDelete(perform: { indexSet in
                    print ("delete")
                    chat.entries.remove(atOffsets: indexSet)

                })
        
                
            }
        Spacer()
        }
        
                           }
  




struct LobbyChatView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyChatView()
    }
}
