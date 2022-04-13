//
//  StoneTestView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct OnlineUsersView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserCoreData.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserCoreData>

    
    @StateObject var firestoreUserModel = FirestoreUserModel()
    @StateObject var firestoreUserOnlineModel = FirestoreUserOnlineModel()
    
    @State var showProfileView: Bool = false
    
    @State var profileId: String?
    
    init() {
        
    }
    
    var body: some View {
        
        VStack {
            Text("Test View")
            
            HStack{
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                } label: {
                    Text("< Lobby")
                }
                
                Spacer()
                
                Button {
                    let coredataUserModel = CoredataUserModel()
                    for user in users {
                        coredataUserModel.deleteUser(user: user)
                    }
                    
                    AppIndexManager.singletonObject.logout()
                } label: {
                    Text("Logout")
                }
                
            }.padding()
            
            List{
                ForEach (firestoreUserOnlineModel.usersOnline) { userOnline in
                    
                    
                    Button {
                        firestoreUserModel.getProfileUser(profileId: userOnline.id)
                    } label: {
                        HStack{
                            
                            Text(userOnline.username)
                            Spacer()
                            Text("Online")
                            Color.green
                                .frame(width: 25, height: 25)
                                .cornerRadius(100)
                            
                        }
                    }
                    .sheet(isPresented: $firestoreUserModel.profileUserActive){
                        ProfileView(_user: firestoreUserModel.profileUser!)
                    }
                }
            }
        }.onAppear {
            firestoreUserOnlineModel.listenToOnlineUsers()
        }
    }
}

struct StoneTestView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineUsersView()
    }
}
