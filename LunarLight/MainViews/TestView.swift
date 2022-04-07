//
//  StoneTestView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct TestView: View {
    
    @StateObject var firestoreUserModel = FirestoreUserModel()
    
    init() {
        
    }
    
    var body: some View {
        
        VStack {
            Text("Test View")
            
            List{
                ForEach (firestoreUserModel.usersOnline) { userOnline in
                    
                    HStack{
                        Text(userOnline.id)
                        Text("Online")
                        Color.green
                    }
                }
            }
        }.onAppear {
            firestoreUserModel.listenToOnlineUsers()
        }
        
        
    }
}

struct StoneTestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
