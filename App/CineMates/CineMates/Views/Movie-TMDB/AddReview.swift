//
//  Review.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 16/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import Foundation

import SwiftUI

struct AddReview: View {
    @Binding var movieTitle : String
    @Binding var movieId : Int
    @State var review: String = ""
    @State var vote : Double = 0
    @State var doneReview : Review?
    @State var api : ApiRev?
    var body: some View {
        Form{
        TextField("Insert here the Review", text: $review)
            VStack{
            Slider(value: $vote, in: 0...10, step: 1)
            Text("Movie Rating: \(Int(vote))")
            }
        }.navigationTitle("Review").toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Done"){
                    doneReview = Review()
                    doneReview!.idMovie = String(self.movieId)
                    doneReview!.body = self.review
                    doneReview!.rating = String(self.vote)
                    doneReview!.title = self.movieTitle
                    print(doneReview?.title)
                    self.api = ApiRev(review: self.doneReview!)
                    print(self.api?.review.title)
                    Task{
                        await api!.addReview()
                    }
                }
            }
        }
    }
}

struct AddReview_Previews: PreviewProvider {
    static var previews: some View {
        AddReview(movieTitle: .constant(""), movieId: .constant(0))
    }
}

