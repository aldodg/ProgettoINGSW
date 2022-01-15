//
//  UserCompleteView.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 12/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

//questa dovrebbe essere anche la view che da un id user fa vedere il suo profilo
//quando faccio la ricerca per username dalla view UserSearchView

//ATTENZIONE!!: usare il model UserComplete e' un casino perche' sminchia liste e review, conviene usare i model
//singoli di questi ultimi due richiamando le api apposite e non quella grossa di userComplete!!

struct UserCompleteView: View {
    let request: String

    @State var userInfo = [Person]()
    
    //request qua sopra indica l'utente che ci ha mandato la richiesta di amicizia che stiamo prendendo in considerazione
    //e' in pratica la chiave id1 della tabella sul db, perche' e' pensato come id1 manda richiesta a id2
    //e in questo caso id2 e' l'id nostro, che stiamo vedendo quali richieste sono arrivate
    //nel model questo id1 e' indicato semplicemente con id per far andare il foreach
    var body: some View {
        //usando il valore di request ora si dovrebbero fare le richieste con le api per avere username, recensioni e liste di colui che ha mandato la richiesta
        
        ForEach(self.userInfo) {
            user in
            Text(user.username)
        }
        
        Text("")
            .onAppear() {
                ApiUser().loadDataUser(num: request) {
                    user in
                    self.userInfo=user.results
                }
            }
//        ForEach(userList.movies) { movie in
//            Text(movie.id)
//        }
    }
}

//struct UserCompleteView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCompleteView()
//    }
//}
