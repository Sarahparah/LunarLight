//
//  SecurePassword.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-03-31.
//

import SwiftUI
import SimpleToast

struct RegisterView: View {
    
    private var firestoreModel = FirestoreUserModel()
    
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
    var startYear: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    @State private var showToast = false
    private let toastOption = SimpleToastOptions(alignment: .bottom, hideAfter: 2.0, backdrop: Color.white.opacity(0), animation: .default, modifierType: .slide)
    @State private var toastErrorMsg = ""
    
    init(){
        
        currentYear = Calendar.current.component(.year, from: Date())
        minimumYear = Calendar.current.date(from:
                                                DateComponents(year: currentYear-12)) ?? Date()
        maximumYear = Calendar.current.date(from:
                                                DateComponents(year: currentYear-120)) ?? Date()
        startYear = Calendar.current.date(from:
                                        DateComponents(year: currentYear-18)) ?? Date()
        
        firestoreModel.listenToUsers()
        
    }
    
    var body: some View {
        
        VStack{
            
            ScrollView {
                
                VStack{
                    VStack{
                        Text("Username:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                        TextField("Ex.. BillPrill", text: $username)
                            .autocapitalization(.none)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(5)
                            .disableAutocorrection(true)
                    }
                    VStack{
                        
                        Text("Date of birth:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                        Button {
                            showDatePicker.toggle()
                        } label: {
                            
                            Text(dateFormatter.string(from: date))
                                .accentColor(showDatePicker ? Color.blue : Color.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .padding(.top, 0.1)
                        .background(.white)
                        .cornerRadius(5)
                        
                        if showDatePicker {
                            DatePicker("", selection: $date,
                                       in: maximumYear...minimumYear, displayedComponents: [.date])
                                .datePickerStyle(WheelDatePickerStyle())
                                .frame(width: UIScreen.main.bounds.width * 0.8)
                                .background(.white)
                                .cornerRadius(5)
                        }
                    }
                    .padding(.top, 10)
                    
                    VStack{
                        Text("Email:")
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                        
                        TextField("Ex.. bill@email.se", text: $email)
                            .keyboardType(.URL)
                            .autocapitalization(.none)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .disableAutocorrection(true)
                            .background(.white)
                            .cornerRadius(5)
                    }
                    .padding(.top, 10)
                    
                    VStack{
                        
                        Text("Password:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                        HStack{
                            
                            if secured {
                                SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                    .disableAutocorrection(true)
                                    .background(.white)
                                    .cornerRadius(5)
                                //.id(1)
                            } else {
                                
                                // 3
                                
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .disableAutocorrection(true)
                                //.id(1)
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
                        }
                    }
                    .padding(.top, 10)
                    
                    SecureField("Reenter password", text: $passwordTwo)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .disableAutocorrection(true)
                        .background(.white)
                        .cornerRadius(5)
                    
                    
                    
                }
                .frame(width: UIScreen.main.bounds.size.width * 0.9)
                .padding(10)
                .onAppear(perform: {
                    date = startYear
                })
                
                Spacer()
                
                
            }
            
            Button {
                if isValidInput() {
                    Task {
                        let _ = await processRegister()
                    }
                }
            } label: {
                Text("Register")
                    .foregroundColor(.white)
            }
        }
        .simpleToast(isPresented: $showToast, options: toastOption) {
            //
        } content: {
            HStack{
                Text("\(toastErrorMsg)")
                    .padding()
            }.background(Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
    }
    
    private func processRegister() async {
        
        let userId: String = UUID().uuidString
        let year: UInt64 = UInt64(Calendar.current.dateComponents([.year], from: date).year ?? 0)
        if year == 0 {
            print("Error: Failed to proccess year of birth.")
            return
        }
        let month: UInt64 = UInt64(Calendar.current.dateComponents([.month], from: date).month ?? 0)
        if month == 0 {
            print("Error: Failed to proccess month of birth.")
            return
        }
        let day: UInt64 = UInt64(Calendar.current.dateComponents([.day], from: date).day ?? 0)
        if day == 0 {
            print("Error: Failed to proccess day of birth.")
            return
        }
        
        let localData = LocalData()
        
        let stoneIndex = LocalData.getStoneIndex(month: month, day: day)
        let stoneType = localData.profileBackground[stoneIndex]
        let stoneArray = localData.stoneImages[stoneType]
        let avatar: String = stoneArray![0]
        
        AppManager.singletonObject.personalGradientBGColor = LinearGradient(gradient: Gradient(colors: [Color(stoneType), .black]),startPoint: .bottomTrailing, endPoint: .topLeading)
        
        email = email.lowercased()
        
        //let token = Encryption().getToken(input: password)
        
        var token = "error"
        
        let encryption = Encryption()
        
        do {
            
            token = try await encryption.getTokenByHttpRequest(input: password)
            if token == "error" {
                return
            }
        } catch {
            print("Error", error)
            return
        }
        
        if token == "error" {
            return
        }
        
        print("DanneToken = \(token)")
        
        let newUser = UserFirebase(_id: userId, _username: username, _email: email, _password: token, _year: year, _month: month, _day: day, _avatar: avatar, _profileInfo: "This is me dude")
        
        //1. create user document
        firestoreModel.createUser(newUser: newUser)
        
        //2. create user online document
        let userOnline = UserOnlineFirebase(_id: newUser.id, _username: newUser.username, _isOnline: true)
        let firestoreUserOnlineModel = FirestoreUserOnlineModel()
        firestoreUserOnlineModel.createUserOnline(newUserOnline: userOnline)
        
        //3. store user in coredata (local database) for auto-login
        let coredataUserModel = CoredataUserModel()
        coredataUserModel.createUser(currentUser: newUser)
        
        //4. Store login data (id + username) in variable and show welcome view
        AppManager.singletonObject.loggedInUser = newUser
        print("username: \(AppManager.singletonObject.loggedInUser.username)")
        
        AppManager.singletonObject.appIndex = AppIndex.welcomeView
    }
    
    private func isUsernameAndEmailUnique() -> Bool {
        let users = firestoreModel.users
        
        print(users)
        
        for user in users {
            if user.username.lowercased() == username.lowercased() ||
                user.email.lowercased() == email.lowercased() {
                
                return false
            }
        }
        return true
    }
    
    private func isValidInput() -> Bool {
        
        if username.count < 3 || username.count > 12 {
            toastErrorMsg = "Username needs to be between 3 and 12 chars."
            showToast = true
            return false
        }
        
        if !inputValidator.isValidUsername(username) {
            toastErrorMsg = "Username cannot contain special chars."
            showToast = true
            return false
        }
        
        if !inputValidator.isValidEmail(email) {
            toastErrorMsg = "Email wrong format."
            showToast = true
            return false
        }
        
        if !isUsernameAndEmailUnique() {
            toastErrorMsg = "Username/Email not unique."
            showToast = true
            return false
        }
        
        if password.count < 5 {
            toastErrorMsg = "Password must be at least 5 chars."
            showToast = true
            return false
        }
        
        if password != passwordTwo {
            toastErrorMsg = "Passwords do not match."
            showToast = true
            return false
        }
        
        print("register completed")
        return true
    }
}

struct SecurePassword_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegisterView()
            
                .previewInterfaceOrientation(.portrait)
        }
    }
}
