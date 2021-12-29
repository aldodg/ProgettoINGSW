//
//  NotificationView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 28/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct FriendshipRequestView: View {
    
    let request_list = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(request_list) { section in
                    ForEach(section.items) { item in
                        NavigationLink(destination: ItemDetail(item: item)) {
                            ItemRow(item: item)
                        }
                    }
                }
            }
            .navigationTitle("Link Requests")
            .listStyle(.grouped)
        }
    }
}

struct FriendshipRequestView_Previews: PreviewProvider {
    static var previews: some View {
        FriendshipRequestView()
    }
}
