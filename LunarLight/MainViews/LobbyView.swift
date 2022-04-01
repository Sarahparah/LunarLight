//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct LobbyView: View {
    var body: some View {
        
        Button {
            AppIndexManager.singletonObject.appIndex = AppIndex.chatView
        } label: {
            Text("go to chat room")
        }

        
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
