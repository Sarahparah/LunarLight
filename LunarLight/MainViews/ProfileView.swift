//
//  ProfileView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-05.
//

import SwiftUI

struct ProfileView: View {
    
    @State var entries = [ChatEntry]()
    @State private var showingSheet = false
    @State var index = 0
    
    var name: String
    var stone : String
    var stoneColor : String
    
    @State var infoText = ["hej detta är försts fältet om mig",
                    "Detta är din månadssten. den är vacker bl bla"]
    
    init(){
        let testData = LocalData()
        
        print("username: \(AppIndexManager.singletonObject.currentUser.username)")
        
        stone = testData.stoneArray[3]
        name = AppIndexManager.singletonObject.currentUser.username
        stoneColor = testData.stoneColorBackground[0]
    }
    
    var body: some View {
        
        ZStack{
            Color(stoneColor)
                .edgesIgnoringSafeArea(.top)
            
            
            
            
            VStack{
                
                //knappen för settings sheet
                HStack{
                    
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                        
                    }.sheet(isPresented: $showingSheet){
                        SheetView()
                    }
                    
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(5)
                    
                    
                }.padding()
                
               
                
                //Namn och profilbild
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text(name)
                    .font(.title).bold()
                    .padding()
                
                //tab view items
                HStack{
                    
                    Button(action: {
                        
                        self.index = 0
                    }) {
                        
                        Text("About me")
                            .foregroundColor(self.index == 0 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 0 ? Color.gray : Color.clear)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        
                        self.index = 1
                        
                    }) {
                        
                        Text(stone)
                            .foregroundColor(self.index == 1 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 1 ? Color.gray : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal,10)
                .padding(.vertical, 5)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                .shadow(color: Color.pink.opacity(0.5), radius: 5, x: -5, y: -5)
                
                if index == 0 {
                    TextField("", text: $infoText[0])
                    
                }else{
                    Text(infoText[1])
                }
                
               Spacer()
                
            }
            
        }
        
    }
}

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var resetPassword: String = ""
    
    var body: some View {
        
        
        Button {
            print("dismiss")
            dismiss()
        } label: {
            Text("dismiss")
                .foregroundColor(.white)
            .font(.title)
            .padding()
            .background(Color.black)
        }

        
        
    
    VStack{
        
        HStack{
            Text("Reset password")
            TextField("Reset password", text: $resetPassword)
        }
        
        
        
    }
}
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
