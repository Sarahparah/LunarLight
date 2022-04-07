//
//  LoginView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI

struct LoginView: View {
    
    private let firestoreUserModel = FirestoreUserModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var secured: Bool = true
    
    @State private var currentUser: UserFirebase?
    
    init() {
        firestoreUserModel.listenToFirestore()
    }
    
    var body: some View {
        VStack {
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
            
            HStack{
                
                if secured {
                    
                    
                    SecureField("Password", text: $password)
                        .padding(4)
                        .border(Color.black, width: 1)
                } else {
                    
                    // 3
                    TextField("Password", text: $password)
                        .padding(4)
                        .border(Color.black, width: 1)
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
                    firestoreUserModel.updateOnlineUser(currentUserOnline: userOnline)
                    
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
            if (user.username == email || user.email == email) && user.password == password {
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
