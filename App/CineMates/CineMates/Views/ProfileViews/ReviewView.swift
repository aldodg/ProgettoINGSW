//
//  ReviewView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 29/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct ReviewView: View {
    
    @State var reviewLists = [ReviewList]()
    
    let num = "1"
    //questo num e' ovviamente d'esempio, e' l'id dell'utente che chiama la funzione
    
    var body: some View {
        ForEach(self.reviewLists) { reviewList in
            NavigationLink(destination: DetailReviewView(reviewList: reviewList)){
                //qua mettere titolo film con api relativa(?)
                Text(reviewList.title)
            }
        }
        
        
        Text("")
            .padding()
            .onAppear() {
                ApiReview().loadDataReview(num: num) { (list) in
                    self.reviewLists = list.reviewLists
                }
            }.navigationTitle("Reviews")
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
