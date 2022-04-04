//
//  SecurePassword.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI

struct RegisterView: View {
    
    private let inputValidator = InputValidator()
    
    @State private var password: String = ""
    @State private var passwordTwo: String = ""
    @State private var secured: Bool = true
    
    @State private var email: String = ""
    @State private var passwordCheck: String = ""
    @State private var username: String = ""
    
    @State private var showDatePicker: Bool = false
    @State private var date: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        
        VStack{
            
            TextField("Username", text: $username)
                
            Button {
                showDatePicker.toggle()
            } label: {
                
                HStack{
                    Text("Date of Birth")
                        .padding(.trailing, 20)
                        
                    Text(dateFormatter.string(from: date))
                }
                
                Spacer()
                
                
            }

            if showDatePicker {
                DatePicker("Select Birthdate", selection: $date,
                           displayedComponents: [.date])
                    .accentColor(Color.red)
                    .datePickerStyle(
                        WheelDatePickerStyle()
                    )
            }
            
            TextField("Email", text: $email)
            
            HStack{
                
                if secured {
                    
                    
                    SecureField("Password", text: $password)
                        .padding(4)
                        .border(Color.black, width: 1)
                        .id(1)
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
            
            SecureField("Reenter password", text: $passwordTwo)
                .padding(4)
                .border(Color.black, width: 1)
                .id(2)
                 
            
            Spacer()
            
            Button {
                
                if processRegister() {
                    AppIndexManager.singletonObject.appIndex = AppIndex.registerQuestionsView
                    let coredataUserModel = CoredataUserModel()
                    coredataUserModel.saveUser(username: username, password: password, dateOfBirth: date, email: email)
                    print()
                }
                
            } label: {
                Text("Register")
            }.padding(.bottom, 20)
            
            
            
        }
        
        
    }
    
    private func processRegister() -> Bool {
        
        if password != passwordTwo {
            print("Password not the same buga buga")
            return false
        }
        
        if !inputValidator.isValidEmail(email) {
            print("Email wrong format")
            return false
        }
        
        print("register")
        return true
        
    }
    
}

struct SecurePassword_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
