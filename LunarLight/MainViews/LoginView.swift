//
//  LoginView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI

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
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            HStack{
                
                if secured {
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding(4)
                        .border(Color.black, width: 1)
                        .disableAutocorrection(true)
                } else {
                    
                    // 3
                    TextField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding(4)
                        .border(Color.black, width: 1)
                        .disableAutocorrection(true)
                }
                
                Button(action: {
                    self.secured.toggle()
                }) {
                    
                    
                    if secured {
                        Image(systemName: "eye.slash")
                    } else {
                        Image(systemName: "eye")
                    }
                }
            }
            
            Spacer()
            
            Button {
                print("login?")
                if loginCheck() {
                    guard let currentUser = currentUser else {
                        print("Error: Current user is nil")
                        return
                    }
                    
                    login(currentUser: currentUser)               }
            } label: {
                Text("Login")
            }
        }
        
        ForEach(users){ user in
            
            if let username = user.username {
                Text(username)
                    .onAppear(){
                        checkAutoLogin(user: user)
                    }
            }
        }
        
    }
    
    private func checkAutoLogin(user: UserCoreData) {
        
        let id = user.id!
        let username = user.username!
        let password = user.password!
        let email = user.email!
        let year = UInt64(user.year)
        let month = UInt64(user.month)
        let day = UInt64(user.day)
        let avatar = user.avatar!
        
        let userFirebase = UserFirebase(_id: id, _username: username, _email: email, _password: password, _year: year, _month: month, _day: day, _avatar: avatar)
        
        AppIndexManager.singletonObject.currentUser = userFirebase
        login(currentUser: userFirebase)
    }
    
    private func login(currentUser: UserFirebase){
        
        let userCoreData = UserCoreData(context: viewContext)
        userCoreData.id = currentUser.id
        userCoreData.username = currentUser.username
        userCoreData.email = currentUser.email
        userCoreData.password = currentUser.password
        userCoreData.year = Int64(currentUser.year)
        userCoreData.month = Int64(currentUser.month)
        userCoreData.day = Int64(currentUser.day)
        userCoreData.avatar = currentUser.avatar
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save CoreData user")
        }
        
        let userOnline = UserOnlineFirebase(_id: currentUser.id, _username: currentUser.username, _isOnline: true)
        firestoreUserOnlineModel.updateOnlineUser(currentUserOnline: userOnline)
        
        AppIndexManager.singletonObject.currentUser = currentUser
        print("username: \(AppIndexManager.singletonObject.currentUser.username)")
        AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
        
    }
    
    private func loginCheck() -> Bool {
        
        let users = firestoreUserModel.users
        
        for user in users {
            if (user.username.lowercased() == email.lowercased() ||
                user.email.lowercased() == email.lowercased()) && user.password == password {
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
