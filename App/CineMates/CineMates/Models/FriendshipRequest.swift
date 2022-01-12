////
////  FriendshipRequest.swift
////  CineMates
////
////  Created by Aldo Di Giovanni on 07/01/22.
////  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
////
//
import Foundation

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

    func FriendshipRequestResponseTask(with url: URL, completionHandler: @escaping (RequestResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}


struct RequestResponse: Codable {
    let status: Int
    let friendshipRequests: [FriendshipRequest]
    init() {
        status = 1
        friendshipRequests = []
    }
    enum CodingKeys: String, CodingKey {
            case status
            case friendshipRequests = "info"
        }
}

struct FriendshipRequest: Codable, Identifiable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "id1"
    }
}

class ApiFriendshipRequest : ObservableObject{
    @Published var request = RequestResponse()
    
    func loadDataRequest(completion:@escaping (RequestResponse) -> ()) {
        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getFriendshipRequest_idUser.php/info?id=1")
        else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.request = try! JSONDecoder().decode(RequestResponse.self, from: data!)
            print(self.request)
            DispatchQueue.main.async {
                completion(self.request)
            }
        }.resume()
        
    }
}
