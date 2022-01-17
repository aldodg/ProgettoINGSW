//
//  postReview.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 16/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import Foundation

// MARK: - List
struct RevResp: Codable {
    let status: Int
    let reviewLists: [Review]
    init() {
        status = 1
        reviewLists = []
    }
    enum CodingKeys: String, CodingKey {
            case status
            case reviewLists = "info"
        }
}
// MARK: - Info
struct Review: Codable, Identifiable {
    var id, title, body: String
    var rating, idMovie: String
    init(){
        id = ""
        title = ""
        body = ""
        rating = ""
        idMovie = ""
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title, body, rating
        case idMovie = "id_movie"
    }
}

class ApiRev {
    var review : Review
    init(review: Review){
        self.review = review
    }
    
//    func addReview() async{
//        guard let encoded = try? JSONEncoder().encode(self.review) else {
//            print("Failed to encode order")
//            return
//        }
//        let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/postReviewJSON.php")!
//        var request = URLRequest(url: url)
//        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
//        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
////        let data : Data = "username=\(user1)&password=\(pass)&email=\(email)&grant_type=password".data(using: .utf8)!
//
//        let data: Data""
//        request.httpMethod = "POST"
//        do {
//            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
//            // handle the result
//        } catch {
//            print("Checkout failed.")
//        }
//    }
   
    func addReview() async{
            guard let encoded = try? JSONEncoder().encode(self.review) else {
                print("Failed to encode order")
                return
            }
            let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/postReviewJSON.php")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            do {
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                // handle the result
            } catch {
                print("Checkout failed.")
            }
        }
    
}
