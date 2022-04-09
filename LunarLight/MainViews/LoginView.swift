//
//  LoginView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI

struct LoginView: View {
    
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
                    
                    let userOnline = UserOnlineFirebase(_id: currentUser.id, _username: currentUser.username, _isOnline: true)
                    firestoreUserOnlineModel.updateOnlineUser(currentUserOnline: userOnline)
                    
                    AppIndexManager.singletonObject.currentUser = currentUser
                    print("username: \(AppIndexManager.singletonObject.currentUser.username)")
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                }
            } label: {
                Text("Login")
            }
        }
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
