//////
//////  Review.swift
//////  CineMates
//////
//////  Created by Aldo Di Giovanni on 07/01/22.
//////  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//////

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
import SwiftUI

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func ReviewResponseTask(with url: URL, completionHandler: @escaping (ReviewResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
 
// MARK: - List
struct ReviewResponse: Codable {
    let status: Int
    let reviewLists: [ReviewList]
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
struct ReviewList: Codable, Identifiable {
    let userID, id, title, body: String
    let rating, idMovie: String

    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case id = "id_review"
        case title, body, rating
        case idMovie = "id_movie"
    }
}

class ApiReview : ObservableObject{
    @Published var review = ReviewResponse()
    
    func loadDataReview(num: String, completion:@escaping (ReviewResponse?,Error?) -> ()) {
        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getReview_idUser.php/info?id=\(num)")
        //guard let url = URL(string: "http://localhost/cinemates/getList_idUser.php/info?id=1")
        else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                self.review = try JSONDecoder().decode(ReviewResponse.self, from: data!)
                print(self.review)
                DispatchQueue.main.async {
                    completion(self.review, nil)
                }
            }
            catch{
                completion(nil,error)
            }
        }.resume()
        
    }
}
