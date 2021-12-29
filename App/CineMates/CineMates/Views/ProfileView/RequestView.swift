//
//  NotificationView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 28/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct RequestView: View {
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
