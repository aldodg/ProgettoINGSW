//
//  LoginView.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 15/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("Login") {
            // test user regsitation body
            let body = UserRegistration(
                username: "test",
                password: "password",
                email: "test@yopmail.com"
            )

            // registration endpoint
            let endpoint = "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/postRegistration.php"

            UserRegistrationRequest.taskForPOSTRequest(endpoint: endpoint, body: body) { (success, error) in

                if let _ = success {
                    print("ProfileView: Success: User registered")
                    presentationMode.wrappedValue.dismiss()
                }

                if let error = error {
                    print(error)
                }
            }
        }
        .padding().frame(width: 150.0, height: 50.0).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
