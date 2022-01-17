//
//  LoginRequest.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 15/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import Foundation
import NetworkLibrary
import SwiftUI

//enum API {
//    case login
//    case posts
//
//    var url: URL {
//        var component = URLComponents()
//        switch self {
//        case .login:
//            component.scheme = "https"
//            component.host = "reqres.in"
//            component.path = path
//        case .posts:
//            component.scheme = "https"
//            component.host = "jsonplaceholder.typicode.com"
//            component.path = path
//        }
//        return component.url!
//    }
//}
//
//extension API {
//    fileprivate var path: String {
//        switch self {
//        case .login:
//            return "/api/login"
//        case .posts:
//            return "/posts"
//        }
//    }
//}
//
//class LoginViewModel: ObservableObject {
//
//    @Published var username: String = "" // "eve.holt@reqres.in"
//    @Published var password: String = "" // "cityslicka"
//    @Published var loading: Bool = false
//    @Published var login: Bool = false
//
//    private var anyNetworkManager: AnyNetworkManager<URLSession>
//
//    init<T: NetworkManagerProtocol>(networkManager: T) {
//        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
//    }
//
//    func loginNetworkCall() {
//        let data: [String : Any] = ["email": username, "password": password]
//        self.loading = true
//        self.login = false
//        anyNetworkManager.fetch(url: API.login.url, method: .post(body: data), completionBlock: {[weak self] res in
//            switch res {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                if let _ = try? decoder.decode(Login.self, from: data) {
//                    DispatchQueue.main.async {
//                        self?.login = true
//                    }
//                } else {
//                    // potential here to update the view with an error
//                }
//            case .failure(let error):
//                // potential here to update the view with an error
//                print ("Error \(error)")
//            }
//            DispatchQueue.main.async {
//                self?.loading = false
//            }
//        })
//    }
//}
//------------------------------------------------------


//import Foundation
//
struct UserRegistration: Codable {
    let username: String
    let password: String
    let email: String
}

struct UserRegistrationResponse: Codable {
    let status: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "Success"
    }
}

class UserRegistrationRequest {

    class func taskForPOSTRequest(
        endpoint: String,
        body: UserRegistration,
        completion: @escaping (UserRegistrationResponse?, String?) -> Void
    ) {


        // ensure no user is already logged in
        guard !AppDelegate.isUserLoggedIn else {
            return
        }

        guard let url = URL(string: endpoint) else {
            print("LoginRequest.taskForPOSTRequest Error: Generating endpointUrl failed!")
            return
        }

        //let data: [String : String] = ["email": body.username, "password": body.password, "username": body.username]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.httpBody = try! JSONEncoder().encode(body)
        let encoder = JSONEncoder()
        if let json = try? encoder.encode(body) {
            print(String(data: json, encoding: .utf8)!)
        }

        //print(String(data: request.httpBody!, encoding: .utf8))

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            // check for url session error
            if let error = error {
                print("LoginRequest.taskForPOSTRequest Error: Failed to Log user in!")
                completion(nil, error.localizedDescription)
                return
            }

            // check server repsonse
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let errorMessage = "LoginRequest.taskForPOSTRequest Error: Server reponsed with error!"
                print(errorMessage)
                completion(nil, errorMessage)
                return
            }

            // check for bad reponse data
            guard let data = data else {
                let errorMessage = "LoginRequest.taskForPOSTRequest Error: Problem with data returned from serevr!"
                print(errorMessage)
                completion(nil, errorMessage)
                return
            }

            //success
            if let postResponse = try? JSONDecoder().decode(UserRegistrationResponse.self, from: data),
               postResponse.status == 1 {
                AppDelegate.isUserLoggedIn = true
                completion(postResponse, nil)
                return

            // error
            } else {
                let errorMessage = "LoginRequest.taskForPOSTRequest Error: Problem decoding data in response!"
                print(errorMessage)
                completion(nil, errorMessage)
                return
            }

        }.resume()
    }
}
// --------------------------------------------


//
//struct UserRegistration: Codable {
//    let username: String
//    let password: String
//    let email: String
//}
//
//struct UserRegistrationResponse: Codable {
//    let status: Int
//    let statusMessage: String
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case statusMessage = "Success"
//    }
//}
//
//class UserRegistrationRequest {
//
//    class func taskForPOSTRequest(
//        endpoint: String,
//        body: UserRegistration,
//        completion: @escaping (UserRegistrationResponse?, String?) -> Void
//    ) {
//
//
//        // ensure no user is already logged in
//        guard !AppDelegate.isUserLoggedIn else {
//            return
//        }
//
//        guard let url = URL(string: endpoint) else {
//            print("LoginRequest.taskForPOSTRequest Error: Generating endpointUrl failed!")
//            return
//        }
//
//        //let data: [String : String] = ["email": body.username, "password": body.password, "username": body.username]
//
//        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/postRegistration.php") else {
//              return
//          }
//
//
//          let user1 = "vdfv"
//          let pass = "fdvdfv"
//          let email = "ismipms"
//          print(user1)
//          print(pass)
//          let data : Data = "username=\(user1)&password=\(pass)&email=\(email)&grant_type=password".data(using: .utf8)!
//          var request : URLRequest = URLRequest(url: url)
//          request.httpMethod = "POST"
//          request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
//          request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
//          request.httpBody = data
//
//          print("one called")
//
//          let config = URLSessionConfiguration.default
//          let session = URLSession(configuration: config)
//          // vs let session = URLSession.shared
//            // make the request
//          let task = session.dataTask(with: request, completionHandler: {
//              (data, response, error) in
//
//               if let error = error
//              {
//                  print(error)
//              }
//               else if let response = response {
//                  print("here in response")
//                  AppDelegate.isUserLoggedIn = true
//
//              }else if let data = data
//               {
//                  print("here in data")
//                  print(data)
//              }
//
//              DispatchQueue.main.async { // Correct
//
//                  guard let responseData = data else {
//                      print("Error: did not receive data")
//                      return
//                  }
//
//                  let decoder = JSONDecoder()
//                  print(String(data: responseData, encoding: .utf8))
//                  do {
//                    //  let todo = try decoder.decode(T.self, from: responseData)
//                    //  NSAssertionHandler(.success(todo))
//                  } catch {
//                      print("error trying to convert data to JSON")
//                      //print(error)
//                    //  NSAssertionHandler(.failure(error))
//                  }
//              }
//          })
//          task.resume()
//
//
//        }
//}
