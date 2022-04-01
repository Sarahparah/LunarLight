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
                print("login")
                AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
            } label: {
                Text("Login")
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
