//
//  DetailReviewView.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 12/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct DetailReviewView: View {
    let reviewList: ReviewList
    var body: some View {
        VStack {
            Text(reviewList.title)
            Text(reviewList.rating)
                .frame(alignment: .center)
            ScrollView {
                Text(reviewList.body)
            }
        }
    }
}

//struct DetailReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailReviewView()
//    }
//}
