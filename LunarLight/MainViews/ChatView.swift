//
//  ChatView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        HStack{
            
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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
