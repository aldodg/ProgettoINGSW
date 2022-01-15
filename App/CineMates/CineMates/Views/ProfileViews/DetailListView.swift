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
    
    //var movie_name : MovieNameResponse
    
        var body: some View {
            ForEach(userList.movies) { movie in
                Text(movie.id)
            }
        }
//    var body: some View {
//        ForEach(userList.movies) { movie in
//            Text("")
//                .onAppear() {
//                    ApiMovieName().loadData (num: movie.id) {
//                        name in self.movie_name = name.movieNameLists
//                    }
//                }
//        }
//    }
}

//struct DetailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailListView()
//    }
//}
