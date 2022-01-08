//
//  ListView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 29/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @State var infos = [Info]()
    
    var body: some View {
        
        Text("Hello, world!")
            .padding()
            .onAppear() {
                Api().loadData { (list) in
                    self.infos = list.info
                }
            }.navigationTitle("Lists")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
