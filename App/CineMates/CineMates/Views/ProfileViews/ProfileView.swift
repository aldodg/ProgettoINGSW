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
                        .padding()
                }
                //.navigationTitle("Profile Page")
                
                NavigationLink(destination: ListView()) {
                    Text("My Lists")
                        .padding()
                }
                //.navigationTitle("Profile Page")
                
                NavigationLink(destination: ReviewView()) {
                    Text("My Reviews")
                        .padding()
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
