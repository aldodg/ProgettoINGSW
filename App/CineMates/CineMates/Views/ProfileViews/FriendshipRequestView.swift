//
//  NotificationView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 28/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI


struct FriendshipRequestView: View {
    @State var friendshipRequests = [FriendshipRequest]()
    
    var body: some View {
        ForEach(self.friendshipRequests) { request in
            NavigationLink(destination: UserCompleteView(request: request)){
                //qua mettere username e bottoni per accettare o rifiutare
                Text(request.id)
            }
            
        }
        Text("")
            .padding()
            .onAppear() {
                ApiFriendshipRequest().loadDataRequest { (list) in
                    self.friendshipRequests = list.friendshipRequests
                }
            }.navigationTitle("Friendship Requests")
    }
}




//struct FriendshipRequestView: View {
//    @State var infos = [Informations]()
//    let loader = Loader()
//
//    var body: some View {
//        List{
//            ForEach(self.infos) { section in
//                Text(section.idMovie)
//                }.onAppear(){
//                    print("ID MOVIE \(self.infos[0].idMovie)--\(self.infos[1].idMovie)")
//                }
//        }.navigationTitle("Link Request").listStyle(.grouped).onAppear(){
//            let urlString = "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getUserComplete_idUser.php/info?id=1"
//                loader.loadData(from: urlString){ result in
//
//                //safe unwrap list, at this stage, it should not be nil
//                guard let result = result else {
//                    print("ContentView: List is nil!")
//                    return
//                }
//                self.infos = result
//                print("ContentView: Successfully populated infoItems with \(infos.count) item(s)!")
//        }
//    }
//}
//
//}
