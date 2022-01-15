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
    
    @State var movieDetail = IdToMovieNameResponse()
    @State var error = false
    
        var body: some View {
            ForEach(userList.movies) { movie in
                Text(movie.id)
            }
        }
    }
    
//    var body: some View {
//
//        Text((movieDetail.name==nil||error) ? "No movie found" : movieDetail.name!).onAppear() {
//            ApiMovieName().loadData (num: userList.id) { movie,error in
//
//                if(error != nil || movie == nil){
//                    self.error = true
//                }
//                else{
//                    self.movieDetail = movie!
//                }
//            }
//        }
//    }
//}

//struct DetailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailListView()
//    }
//}
