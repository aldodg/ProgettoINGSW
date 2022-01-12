//
//  DetailListView.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 12/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct DetailListView: View {
    let userList: MovieList
    var body: some View {
        ForEach(userList.movies) { movie in
            Text(movie.id)
        }
    }
}

//struct DetailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailListView()
//    }
//}
