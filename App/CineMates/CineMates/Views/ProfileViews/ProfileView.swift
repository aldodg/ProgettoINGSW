//
//  ProfileView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 28/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showLoginScreen = false

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
            }
            .navigationTitle("My Profile")
            .onAppear {
                if !AppDelegate.isUserLoggedIn {
                    showLoginScreen.toggle()
                }
            }
            
            // Display Login screen
            .fullScreenCover(isPresented: $showLoginScreen) {
                LoginView()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
