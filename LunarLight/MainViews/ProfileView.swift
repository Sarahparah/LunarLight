//
//  ProfileView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-05.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showingSheet = false
    @State var index = 0
    
    let user: UserFirebase
    let readOnly: Bool
    var stone: String
    var backgroundColor: String
    
    
    @State var infoText = ["profileInfo",
                           "stoneInfo"]
    
    init(_user: UserFirebase){
        let localData = LocalData()
        
        user = _user
        readOnly = AppIndexManager.singletonObject.loggedInUser.id == user.id ? false : true
        
        let stoneIndex = UserFirebase.getStoneIndex(month: user.month, day: user.day)
        let stoneType = localData.profileBackground[stoneIndex]
        
        backgroundColor = stoneType
        stone = localData.stoneArray[stoneIndex]
        
        print("Detta är user: \(_user)")
        
    }
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(backgroundColor), .white]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            
            VStack{
                
                if readOnly {
                    Button {
                        addFriend()
                    } label: {
                        Text("Add friend")
                    }
                }
                
                //knappen för settings sheet
                HStack{
                    
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                        
                    }.sheet(isPresented: $showingSheet){
                        SheetView()
                    }
                    
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(5)
                    .opacity(readOnly ? 0 : 1)
                    .disabled(readOnly ? true : false)
                    
                }
                .padding()
                
                //Namn och profilbild
                Image(user.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text(user.username)
                    .font(.title).bold()
                    .padding()
                
                //tab view items
                HStack{
                    
                    Button(action: {
                        
                        self.index = 0
                    }) {
                        
                        Text("About me")
                            .foregroundColor(self.index == 0 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 0 ? Color.gray : Color.clear)
                            .cornerRadius(10)
                            .onAppear {
                                infoText[0] = user.profile_info
                            }
                        
                    }
                    Button(action: {
                        
                        self.index = 1
                        
                    }) {
                        
                        Text(stone)
                            .foregroundColor(self.index == 1 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 1 ? Color.gray : Color.clear)
                            .cornerRadius(10)
                            .onAppear {
                                let localData = LocalData()
                                print(stone)
                                infoText[1] = localData.stonesInfo[stone] ?? "Could not find stone info."
                            }
                    }
                }
                .padding(.horizontal,10)
                .padding(.vertical, 5)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                .shadow(color: Color(backgroundColor).opacity(0.5), radius: 5, x: -5, y: -5)
                
                ScrollView{
                    
                    
                    if index == 0 {
                        if readOnly {
                            Text(infoText[0])
                        }
                        else {
                            TextField(user.profile_info, text: $infoText[0])
                            
                            Button {
                                updateUser()
                                
                                
                            } label: {
                                Text("Save")
                            }
                        }
                        
                    }else{
                        Text(infoText[1])
                    }
                    
                    Spacer()
                }.padding()
                
            }
        }.onAppear {
            if user.id == AppIndexManager.singletonObject.loggedInUser.id {
                infoText[0] = AppIndexManager.singletonObject.loggedInUser.profile_info
                
            }
        }
    }
    
    private func addFriend() {
        
        let friendId = user.id
        
        let newFriend = FriendFirebase(_userId: friendId)
        
        let firestoreFriendModel = FirestoreFriendModel()
        
        firestoreFriendModel.createFriend(newFriend: newFriend)
        
    }
    
    private func updateUser(){
        
        AppIndexManager.singletonObject.loggedInUser.profile_info = infoText[0]
        let firestoreUserModel = FirestoreUserModel()
        firestoreUserModel.updateUser(currentUser: AppIndexManager.singletonObject.loggedInUser)
        
        let  coreDataUserModel = CoredataUserModel()
        coreDataUserModel.updateUser(userFirebase: AppIndexManager.singletonObject.loggedInUser)
        
    }
    
}

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var resetPassword: String = ""
    
    var body: some View {
        
        
        Button {
            print("dismiss")
            dismiss()
        } label: {
            Text("dismiss")
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .background(Color.black)
        }
        
        VStack{
            
            HStack{
                Text("Reset password")
                TextField("Reset password", text: $resetPassword)
            }
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(_user: AppIndexManager.singletonObject.testUser)
    }
}
