//
//  LoginView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI
import CoreData
import UIKit
import SimpleToast

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
    
    @State private var showToast = false
    private let toastOption = SimpleToastOptions(alignment: .bottom, hideAfter: 2.0, backdrop: Color.white.opacity(0), animation: .default, modifierType: .slide)
    
    init() {
        firestoreUserModel.listenToUsers()
    }
    
    var body: some View {
        
        VStack{
        
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
                    
                    Task {
                        let result = await loginCheck()
                        
                        if (result) {
                            guard let currentUser = currentUser else {
                                print("Error: Current user is nil")
                                return
                            }
                            
                            login(currentUser: currentUser)
                        }
                    }
                
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                }
                
            }.padding(.top, 20)
                .frame(width: UIScreen.main.bounds.size.width * 0.9)


            ForEach(users){ user in
                if let username = user.username {
                    Text(username)
                        .onAppear(){
                            
                            AppIndexManager.singletonObject.coreDataUser = user
                            performAutoLogin(user: user)

                        }
                }
            }
            
        
        }
        .simpleToast(isPresented: $showToast, options: toastOption) {
            //
        } content: {
            HStack{
                Text("Login failed. Please check username/password.")
                    .padding()
            }.background(Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .cornerRadius(20)
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
        AppIndexManager.singletonObject.profileUser = currentUser
        print("username: \(AppIndexManager.singletonObject.loggedInUser.username)")
        AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
        
    }
    
    private func loginCheck() async -> Bool {
        
        let users = firestoreUserModel.users
        
        var token = "error"
        
        let encryption = Encryption()
        
        do {
            
            token = try await encryption.getTokenByHttpRequest(input: password)
            
            if token == "error" {
                return false
            }
        } catch {
                print("Error", error)
                return false
        }
        
        //let token = Encryption().getToken(input: password)
        
        for user in users {
            if (user.username.lowercased() == email.lowercased() ||
                user.email.lowercased() == email.lowercased()) && user.password == token {
                print("Login success =)")
                currentUser = user
                return true
            }
        }
        
        print("Login failed =(")
        showToast = true
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
