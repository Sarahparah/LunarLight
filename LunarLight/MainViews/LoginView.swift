//
//  LoginView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI
import CoreData

struct LoginView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserCoreData.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserCoreData>
    
    private let firestoreUserModel = FirestoreUserModel()
    private let firestoreUserOnlineModel = FirestoreUserOnlineModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var secured: Bool = true
    
    @State private var currentUser: UserFirebase?
    
    init() {
        firestoreUserModel.listenToUsers()
    }
    
    var body: some View {
        VStack {
            
            TextField("Email / Username", text: $email)
                .autocapitalization(.none)
                .padding(10)
                .disableAutocorrection(true)
                .background(.white)
                .cornerRadius(5)
            
            
            HStack{
                
                if secured {
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding(10)
                        .disableAutocorrection(true)
                        .background(.white)
                        .cornerRadius(5)
                    
                } else {
                    
                    // 3
                    TextField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding(10)
                        .disableAutocorrection(true)
                        .background(.white)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    self.secured.toggle()
                }) {
                    
                    
                    if secured {
                        Image(systemName: "eye.slash")
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "eye")
                            .foregroundColor(.white)
                    }
                }
            }.padding(.top, 10)
            
            Spacer()
            
            Button {
                print("login?")
                if loginCheck() {
                    guard let currentUser = currentUser else {
                        print("Error: Current user is nil")
                        return
                    }
                    
                    login(currentUser: currentUser)
                    
                }
            } label: {
                Text("Login")
                    .foregroundColor(.white)
            }
        }.padding(.top, 20)
            .frame(width: UIScreen.main.bounds.size.width * 0.9)

        Button {
            let coredataUserModel = CoredataUserModel()
            for user in users {
                coredataUserModel.deleteUser(user: user)
                
            }
        } label: {
            Text("delete all")
        }

        
        ForEach(users){ user in
            if let username = user.username {
                Text(username)
                    .onAppear(){
                        
//                        AppIndexManager.singletonObject.coreDataUser = user
//                        performAutoLogin(user: user)
//
                    }
            }
        }
        
    }
    
    private func performAutoLogin(user: UserCoreData) {
        
        let id = user.id!
        let username = user.username!
        let password = user.password!
        let email = user.email!
        let year = UInt64(user.year)
        let month = UInt64(user.month)
        let day = UInt64(user.day)
        let avatar = user.avatar!
        let profileInfo = user.profile_info == nil ? "" : user.profile_info!
        
        let userFirebase = UserFirebase(_id: id, _username: username, _email: email, _password: password, _year: year, _month: month, _day: day, _avatar: avatar, _profileInfo: profileInfo)
        
        
        
        AppIndexManager.singletonObject.loggedInUser = userFirebase
        login(currentUser: userFirebase)
    }
    
    private func login(currentUser: UserFirebase){
        
        let coredataUserModel = CoredataUserModel()
        coredataUserModel.createUser(currentUser: currentUser)
        
        let userOnline = UserOnlineFirebase(_id: currentUser.id, _username: currentUser.username, _isOnline: true)
        firestoreUserOnlineModel.updateOnlineUser(currentUserOnline: userOnline)
        
        let localData = LocalData()
        
        let stoneIndex = UserFirebase.getStoneIndex(month: currentUser.month, day: currentUser.day)
        let stoneType = localData.profileBackground[stoneIndex]
        
        AppIndexManager.singletonObject.personalGradientBGColor = LinearGradient(gradient: Gradient(colors: [Color(stoneType), .black]),startPoint: .bottomTrailing, endPoint: .topLeading)
        
        AppIndexManager.singletonObject.loggedInUser = currentUser
        print("username: \(AppIndexManager.singletonObject.loggedInUser.username)")
        AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
        
    }
    
    private func loginCheck() -> Bool {
        
        let users = firestoreUserModel.users
        
        let token = Encryption().getToken(input: password)
        
        for user in users {
            if (user.username.lowercased() == email.lowercased() ||
                user.email.lowercased() == email.lowercased()) && user.password == token {
                print("Login success =)")
                currentUser = user
                return true
            }
        }
        
        print("Login failed =(")
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
