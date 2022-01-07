//
//  ItemRow.swift
//  iDine
//
//  Created by Анастасия Скорюкова on 20/10/21.
//

import SwiftUI

struct ItemRow: View {
    let item: MenuItem
    
    
    var body: some View {
        
        HStack{
            
            Text(item.name)
                .font(.headline)
                //.alignmentGuide(.leading) { d in d[.leading] }
            
            Button("Accept") {
                print("Perform accept")
            }
            
            Button("Refuse", role: .destructive) {
                print("Perform delete")
            }
        }
    }
}


struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
