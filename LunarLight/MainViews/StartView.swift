//
//  ContentView.swift
//  LunarLight
//
//  Created by Daniel, Karol, Sarah, Hampus on 2022-03-31.
//

import SwiftUI
import CoreData

struct StartView: View {
    
    @State private var tabIndex = 0
    
    var body: some View {
    
        VStack{
            
            TabButtons(tabIndex: $tabIndex)
            
            Divider()
            
            Spacer()
            
            if tabIndex == 0 {
                LoginView()
            }else{
                RegisterView()
            }
            Spacer()
            
        }.padding()
        .background(Image("star_bg_sky")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea())
        .background(LinearGradient(gradient: Gradient(colors: [Color("bg_color"), .black]),startPoint: .bottomTrailing, endPoint: .topLeading))
            
    }
}

struct TabButtons: View {
    
    @Binding var tabIndex: Int
    
    var body: some View {
        
        HStack {
            Spacer()
            
            Button {
                tabIndex = 0
            } label: {
                Text("Login")
                    .foregroundColor(.white)
            }
            
                Spacer()
            
            Divider()
                .frame(height: UIScreen.main.bounds.size.height * 0.05)
                .background(.white)
            
            
                Spacer()
            
            Button {
                tabIndex = 1
            } label: {
                Text("Register")
                    .foregroundColor(.white)
            }
            
                Spacer()
        }
        Divider()
            .frame(width: UIScreen.main.bounds.size.width * 0.9)
            .background(.white)
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
