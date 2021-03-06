//
//  ProfileView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-05.
//

import SwiftUI

struct ProfileView: View {
    
    @State var index = 0
    
    @State var user: UserFirebase = AppManager.singletonObject.loggedInUser
    @State var readOnly: Bool = true
    @State var stone: String = ""
    @State var bGColorOfPressedUser: String = ""
    
    @State var infoText = ["profileInfo",
                           "stoneInfo"]
    
    //initiates with test data that is replaced when onAppear() is called
    init() {
        let localData = LocalData()
        
        readOnly = true
        
        let stoneIndex = LocalData.getStoneIndex(month: user.month, day: user.day)
        
        bGColorOfPressedUser = localData.profileBackground[stoneIndex]
  
        stone = localData.stoneArray[stoneIndex]
        
        infoText[0] = user.profile_info
    }
    
    var body: some View {
        

        VStack{
                
            if readOnly {
                Button {
                    addFriend()
                } label: {
                    Text("Add friend")
                        .foregroundColor(.white)
                }
            }

                
            //Namn och profilbild
            Image(user.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 50)
            
            Text(user.username)
                .font(.title).bold()
                .padding()
                .foregroundColor(.white)
            
            //tab view items
            HStack{
                Spacer()
                
                Button(action: {
                    
                    self.index = 0
                }) {
                    
                    Text("About me")
                        .foregroundColor(self.index == 0 ? Color.white : .white.opacity(0.5))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color.black.opacity(0.5) : Color.clear)
                        .cornerRadius(10)
                        .onAppear {
                            infoText[0] = user.profile_info
                        }
                    
                }
                Spacer()
                Button(action: {
                    
                    self.index = 1
                    
                }) {
                    
                    Text(stone)
                        .foregroundColor(self.index == 1 ? Color.white : .white.opacity(0.5))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color.black.opacity(0.5) : Color.clear)
                        .cornerRadius(10)
                        .onAppear {
                            let localData = LocalData()
                            print(stone)
                            infoText[1] = localData.stonesInfo[stone] ?? "Could not find stone info."
                        }
                }
                
                Spacer()
            }
            .padding(.horizontal,10)
            .padding(.vertical, 5)
            .background(Color.white.opacity(0.2))
//                .shadow(color: Color(backgroundColor).opacity(0.5), radius: 5, x: -5, y: -5)
                
                
            //FIXA H??R MED V-STACK och SCROLL VIEW. s?? save knappen hoppar ner.
            ScrollView{
                
                
                if index == 0 {
                    if readOnly {
                        Text(infoText[0])
                            .foregroundColor(.white)
                    }
                    else {
                        TextEditor(text: $infoText[0])
                            .padding()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.2)
                            .background(Color("gradient_white_10"))
                            .cornerRadius(30)
                            .foregroundColor(.white)
                        
                        Spacer ()
                        
                        Button {
                            updateInfoTextUser()
                            
                            
                        } label: {
                            Text("Save")
                        }
                        .padding()
                        .background(Color("gradient_white_10"))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        
                    }
                    
                }else{
                    Text(infoText[1])
                        .padding()
                        .background(Color("gradient_white_10"))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            .padding()
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("star_bg_sky")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea())
        
            .background(
                user.id == AppManager.singletonObject.loggedInUser.id ? AppManager.singletonObject.personalGradientBGColor : LinearGradient(gradient: Gradient(colors: [Color(bGColorOfPressedUser), .black]),startPoint: .bottomTrailing, endPoint: .topLeading))
            .onAppear {
                
                if AppManager.singletonObject.profileUser == nil {
                    AppManager.singletonObject.profileUser = AppManager.singletonObject.loggedInUser
                }
                
                let localData = LocalData()
                
                user = AppManager.singletonObject.profileUser!
                
                readOnly = AppManager.singletonObject.loggedInUser.id == AppManager.singletonObject.profileUser!.id ? false : true
                
                let stoneIndex = LocalData.getStoneIndex(month: user.month, day: user.day)
                
                bGColorOfPressedUser = localData.profileBackground[stoneIndex]
          
                stone = localData.stoneArray[stoneIndex]
                
                infoText[0] = user.profile_info
                
                UITextView.appearance()
                    .backgroundColor = .clear
        
            }
    }
    
    private func addFriend() {
        
        let friendId = user.id
        
        let newFriend = FriendFirebase(_userId: friendId)
        
        let firestoreFriendModel = FirestoreFriendModel()
        
        firestoreFriendModel.createFriend(newFriend: newFriend)
        
    }
    
    private func updateInfoTextUser(){
        
        user.profile_info = infoText[0]
        
        AppManager.singletonObject.loggedInUser.profile_info = infoText[0]
        let firestoreUserModel = FirestoreUserModel()
        firestoreUserModel.updateUser(currentUser: AppManager.singletonObject.loggedInUser)
        
        AppManager.singletonObject.profileUser!.profile_info = infoText[0]
        
        AppManager.singletonObject.coreDataUser?.profile_info = infoText[0]
        let coreDataUserModel = CoredataUserModel()
        coreDataUserModel.updateUser()
        
        
    }
    
}
