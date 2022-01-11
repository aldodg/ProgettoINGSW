//
//  ProfileView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 28/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FriendshipRequestView()) {
                    Text("Link Requests")
                        .padding().frame(width: 150.0, height: 50.0).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                }
                
                NavigationLink(destination: ListView()) {
                    Text("My Lists")
                        .padding().frame(width: 150.0, height: 50.0).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                }
                
                NavigationLink(destination: ReviewView()) {
                    Text("My Reviews")
                        .padding().frame(width: 150.0, height: 50.0).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                }
                .navigationTitle("Profile Page")
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
