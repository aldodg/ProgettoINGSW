//
//  ListView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 29/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @State var userLists = [MovieList]()
    @State var error = false

    let num = "1"
    //questo num e' ovviamente d'esempio, e' l'id dell'utente che chiama la funzione
    
    var body: some View {
        ForEach(self.userLists) { userList in
            NavigationLink(destination: DetailListView(userList: userList)) {
                Text(userList.listName)
            }
        }
        
        
        Text("")
            .padding()
            .onAppear() {
                ApiList().loadData(num: num) { list,error  in
                    if(error == nil){
                        self.userLists = list.movieLists
                    }
                    else{
                        self.error = true
                    }
                }
            }.navigationTitle("Lists")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
