//
//  UserSearchView.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 28/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct UserSearchView: View {
    
    //    @State private var searchText = ""
    
    //@State var users = [UserList]()
    
    //        var body: some View {
    //
    //                Text("Searching for \(searchText)")
    //                    .searchable(text: $searchText, prompt: "Look for someone")
    //                    .navigationTitle("Search User")
    //        }
    
    //    -----------------------------
    
    @ObservedObject var userVM = UserViewModel()
    @State private var searchText = ""
    
    var filteredPeople: [Person] {
        if searchText == "" {
            return userVM.people
        }
        return userVM.people.filter {
            $0.username.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        
        List(filteredPeople) {
            person in
            NavigationLink(destination: UserCompleteView(request: person.id)) {
                Text(person.username)
            }
        }
        .navigationTitle("Search")
        //SENZA PLACEMENT NASCONDE LA BARRA DI RICERCA E PER FARLA COMPARIRE DEVO FARE SCROLL IN BASSO --BUG DI LINGUAGGIO
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}
//    -------------------------------

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
