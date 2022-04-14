//
//  ContentView.swift
//  LunarLight
//
//  Created by Daniel, Karol, Sarah, Hampus on 2022-03-31.
//

import SwiftUI
import CoreData

struct StartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserCoreData.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserCoreData>
    
    @State private var tabIndex = 0

    
    var bGColor = LinearGradient(gradient: Gradient(colors: [Color("bg_color"), .black]), startPoint: .bottomTrailing, endPoint: .topLeading)
    
    var body: some View {
    
        
        ZStack{
            
        
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
            .background(Image("star_heaven")
                    .resizable()
                    .scaledToFill()
                )
            
        }
        .background(bGColor)
        
    }
    
    private func addItem() {
        withAnimation {
            //let newItem = Item(context: viewContext)
            //newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
