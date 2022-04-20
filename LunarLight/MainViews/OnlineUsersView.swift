//
//  StoneTestView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct OnlineUsersView: View {
    
    
    
    @StateObject var firestoreUserModel = FirestoreUserModel()
    @StateObject var firestoreUserOnlineModel = FirestoreUserOnlineModel()
    
    @State var showProfileView: Bool = false
    
    @State var profileId: String?
    
    init() {
        
    }
    
    var body: some View {
        
        VStack {
            Text("Online Users")
            
            HStack{
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                } label: {
                    Text("< Lobby")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                                
            }.padding()
            
            ScrollView{
                ForEach (firestoreUserOnlineModel.usersOnline) { userOnline in
                    
                    
                    Button {
                        firestoreUserModel.getProfileUser(profileId: userOnline.id)
                    } label: {
                        VStack{
                        HStack{
                            
                            Text(userOnline.username)
                                .foregroundColor(.white)
                            Spacer()
                            Text("Online")
                                .foregroundColor(.white)
                            Color.green
                                .frame(width: 25, height: 25)
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .padding(2)
                            
                        }
                            Divider()
                                .frame(width: UIScreen.main.bounds.size.width * 0.9)
                                .background(.white)
                        }
                    }
                    .sheet(isPresented: $firestoreUserModel.profileUserActive){
                        ProfileView()
                    }
                    
                }
            }.padding()
        }.background(Image("star_bg_sky")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea())
            .background(AppIndexManager.singletonObject.personalGradientBGColor)
            .onAppear {
                firestoreUserOnlineModel.listenToOnlineUsers()
                AppIndexManager.singletonObject.profileUser = nil
        }
    }
}

struct StoneTestView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineUsersView()
    }
}
