//
//  ContentView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 23/12/21.
//

import SwiftUI
import NetworkLibrary

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView { MovieHomeView() }
            .tabItem { Label("Home", systemImage: "film")}
            .tag(0)
            
            NavigationView { MovieSearchView() }
            .tabItem { Label("Search Movies", systemImage: "magnifyingglass")}
            .tag(1)
            
            NavigationView { UserSearchView() }
            .tabItem { Label("Search Users", systemImage: "person.2.circle.fill")}
            .tag(2)
            
            ProfileView()
            .tabItem { Label("Profile", systemImage: "person.circle.fill")}
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
