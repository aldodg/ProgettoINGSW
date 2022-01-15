//
//  LoginRequest.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 15/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import Foundation

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
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
            if let postResponse = try? JSONDecoder().decode(UserRegistrationResponse.self, from: data), postResponse.status == 1 {
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
