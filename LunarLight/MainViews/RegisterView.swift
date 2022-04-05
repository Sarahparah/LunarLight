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
    var currentYear: Int = -1
    var minimumYear: Date = Date()
    var maximumYear: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    init(){
        
        currentYear = Calendar.current.component(.year, from: Date())
        minimumYear = Calendar.current.date(from:
            DateComponents(year: currentYear-12)) ?? Date()
        maximumYear = Calendar.current.date(from:
            DateComponents(year: currentYear-120)) ?? Date()
        date = minimumYear
        
    }
    
    var body: some View {
        
        VStack{
            VStack{
                Text("Username:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14))
                
                    
                
                TextField("Ex.. BillPrill", text: $username)
                .multilineTextAlignment(.center)
                .padding(2)
                .border(.black, width: 1.0)
            }
            VStack{
                
            Text("Date of birth:")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 14))
            
            
            Button {
                showDatePicker.toggle()
            } label: {
                    
                    Text(dateFormatter.string(from: minimumYear))
                    .accentColor(showDatePicker ? Color.blue : Color.black)
                
                
               
            }
            .frame(maxWidth: .infinity)
            .padding(4)
            .border(.black, width: 1.0)
            .padding(.top, 0.1)
            .id(8)
            
            
            
            if showDatePicker {
                
               
                
                DatePicker("Select Birthdate", selection: $date,
                    in: maximumYear...minimumYear, displayedComponents: [.date])
                    .accentColor(Color.red)
                    .datePickerStyle(WheelDatePickerStyle())
                }
            }
            .padding(.top, 10)
            
            VStack{
                Text("Email:")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.system(size: 14))
                
                
                TextField("Ex.. bill@email.se", text: $email)
                    .multilineTextAlignment(.center)
                    .padding(2)
                    .border(.black, width: 1.0)
            }
            .padding(.top, 10)
            
            VStack{
                
                Text("Password:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
            HStack{
                
                
                if secured {
                    
                    
                    
                    SecureField("Password", text: $password)
                        .multilineTextAlignment(.center)
                        .padding(2)
                        .border(Color.black, width: 1.0)
                        .id(1)
                } else {
                    
                    // 3
                    
                    Text("Username")
                        .frame(width: UIScreen.main.bounds.size.width * 0.4, alignment: .leading)
                    
                    TextField("Password", text: $password)
                        .padding(2)
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
            }
            .padding(.top, 10)
            
                
            SecureField("Reenter password", text: $passwordTwo)
                .multilineTextAlignment(.center)
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
        .padding()
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
        Group {
            RegisterView()
            RegisterView()
            RegisterView()
.previewInterfaceOrientation(.landscapeRight)
        }
    }
}
