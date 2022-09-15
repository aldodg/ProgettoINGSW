//
//  LoginView.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 15/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//
//
import SwiftUI
import NetworkLibrary

//
//struct LoginView: View {
//    @ObservedObject var viewModel: LoginViewModel
//
//    init(viewModel: LoginViewModel) {
//        self.viewModel = viewModel
//    }
//
//    var body: some View {
//        NavigationView {
//            ZStack{
//                AppBackgroundView()
//                    .zIndex(0)
//                if self.viewModel.loading {
//                    ProgressView()
//                        .zIndex(1)
//                }
//                VStack{
//                    LoginText()
//                    TextField("Username", text: self.$viewModel.username)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                        .autocapitalization(.none)
//                    SecureField("Password", text: self.$viewModel.password)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                    Button("Login", action: loginAction)
//                    NavigationLink(
//                        destination: ProfileView(),
//                        isActive: self.$viewModel.login,
//                        label: {}
//                    )
//                }
//            }
//        }
//    }
//
//    func loginAction() {
//        viewModel.loginNetworkCall()
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        let nm = MockNetworkManager(session: URLSession.shared)
//        LoginView(viewModel: LoginViewModel(networkManager: nm))
//    }
//}
//
//struct LoginText : View {
//    var body: some View {
//        return Text("Login")
//            .font(.headline)
//            .fontWeight(.semibold)
//            .padding(.bottom, 20)
//    }
//}
//
//struct AppBackgroundView: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.clear, .secondary]), startPoint: .top, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
//        }
//    }
//}

//---------------------------------------

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Registrati") {
            // test user regsitation body
            let body = UserRegistration(
                username: "test",
                password: "password",
                email: "test@gmail.com"
            )

            // registration endpoint
            //let endpoint = "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/postRegistrationJSON.php"
            let endpoint = "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/postRegistration.php"

            UserRegistrationRequest.taskForPOSTRequest(endpoint: endpoint, body: body) { (success, error) in

                if let _ = success {
                    print("ProfileView: Success: User registered")
                    presentationMode.wrappedValue.dismiss()
//                    AppDelegate.isUserLoggedIn = true
//                    print("xxxxxxxx")
//                    print(AppDelegate.isUserLoggedIn)
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
