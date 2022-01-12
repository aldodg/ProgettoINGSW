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
    
    var body: some View {
        ForEach(self.userLists) { userList in
            NavigationLink(destination: DetailListView(userList: userList)){
                Text(userList.listName)
            }
        }
        
        
        Text("")
            .padding()
            .onAppear() {
                ApiList().loadData { (list) in
                    self.userLists = list.movieLists
                }
            }.navigationTitle("Lists")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
