//
//  LoginView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var secured: Bool = true
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.id, ascending: true)],
        //predicate: NSPredicate(format: "name BEGINSWITH %@", "G"), //SQL Query
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        VStack {
            
            TextField("Email", text: $email)
            
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
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                }
            } label: {
                Text("Login")
            }
        }
    }
    
    private func loginCheck() -> Bool {
        
        for user in users {
            if (user.username == email || user.email == email) && user.password == password {
                print("Login success =)")
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
