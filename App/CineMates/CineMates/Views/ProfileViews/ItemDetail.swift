//
//  ItemDetail.swift
//  iDine
//
//  Created by Анастасия Скорюкова on 20/10/21.
//

import SwiftUI

struct ItemDetail: View {
    let item: MenuItem
    var body: some View {
        VStack {
            HStack (spacing: 30){
                Button("Accept") {
                    print("Perform accept")
                }
    
                Button("Refuse", role: .destructive) {
                    print("Perform delete")
                }
            }
            //code to show profile detail of the person who made the request
        }
        .navigationTitle(item.name)
        //.navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example)
        }
    }
}
