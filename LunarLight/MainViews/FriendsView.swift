//
//  LobbyChatView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI


struct FriendsView: View {
    
    @StateObject var firestoreFriendsModel = FirestoreFriendsModel()
    @StateObject var chat = Chat()
    @State var showInfo : Bool = false
    
    var body: some View {
        
        VStack{
            NavigationView{
                List{
                    ForEach(firestoreFriendsModel.friends){ entry in
                        Text(entry.user_id)
//                        NavigationLink(destination: ChatView(entry: entry.user_id)){
//                            TitleRow(image: Image(systemName: entry.imageName), name: entry.name)
//                        }
//                        .onAppear(perform: { print(entry.date)})
                        
                    }.onDelete(perform: { indexSet in
                        print ("delete")
                        chat.entries.remove(atOffsets: indexSet)
                        
                    })
                    
                }
            }
            Spacer()
        }.onAppear(){
            firestoreFriendsModel.listenToFriends()
        }
    }
}





struct LobbyChatView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
