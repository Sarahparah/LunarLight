//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct LobbyView: View {
    var body: some View {
        
//        Button {
//            AppIndexManager.singletonObject.appIndex = AppIndex.chatView
//        } label: {
//            Text("Wolrd lobby")
//        }
        Text("Lobbyview")
        
        Button {
            AppIndexManager.singletonObject.appIndex = AppIndex.lobbyChatView

        } label: {
            Text("Go to lobbychatView")
        }


        
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
