////
////  UserByUsername.swift
////  CineMates
////
////  Created by Aldo Di Giovanni on 07/01/22.
////  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
////
//
import Foundation
//-------------------------------------
//enum FetchError: Error {
//    case badURL
//    case badResponse
//}
//
//class StarWarsViewModel: ObservableObject {
//    @Published var people = [Person]()
//
//    init () {
//        Task {
//            people = try await getPeople()
//        }
//    }
//
//    func getPeople() async throws -> [Person] {
//        guard let url=URL(string: "https://swapi.dev/api/people") else {
//            throw FetchError.badURL
//        }
//        let urlRequest = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            throw FetchError.badResponse
//        }
//        let maybePeopleData = try JSONDecoder().decode(PersonResults.self, from: data)
//
//        return maybePeopleData.results
//    }
//}
//
//struct PersonResults: Decodable {
//    var results: [Person]
//}
//struct Person: Decodable, Identifiable {
//    var id = UUID()
//    var name: String
//
//    enum CodingKeys: CodingKey {
//        case name
//    }
//}

// --------------------------------------------
//

enum FetchError: Error {
    case badURL
    case badResponse
}

struct PersonResults: Codable {
    let status: Int
    let results: [Person]
    init() {
        status = 1
        results = []
    }
    enum CodingKeys: String, CodingKey {
            case status
            case results = "info"
        }
}
// MARK: - Info
struct Person: Codable, Identifiable {

        let id, username, password, email: String


//    enum CodingKeys: String, CodingKey {
//        case userID = "id"
//        case id = "id_review"
//        case title, body, rating
//        case idMovie = "id_movie"
//    }
}

class UserViewModel: ObservableObject {
    @Published var people = [Person]()

    init () {
        Task {
            people = try await getPeople()
        }
    }

    func getPeople() async throws -> [Person] {
        //guard let url=URL(string: "https://swapi.dev/api/people") else {
        guard let url=URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getUser_username.php/info?username=accr0") else {
            throw FetchError.badURL
        }
        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badResponse
        }
        let maybePeopleData = try JSONDecoder().decode(PersonResults.self, from: data)

        return maybePeopleData.results
    }
}

//-------------------------------------------------

//extension URLSession {
//    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
//        }
//    }
//
//    func UserByUsernameResponseTask(with url: URL, completionHandler: @escaping (UserResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//}
//
//struct UserResponse: Codable {
//    let status: Int
//    let userLists: [UserList]
//    init() {
//        status = 1
//        userLists = []
//    }
//    enum CodingKeys: String, CodingKey {
//            case status
//            case userLists = "info"
//        }
//}
//// MARK: - Info
//struct UserList: Codable, Identifiable {
//
//        let id, username, password, email: String
//
//
////    enum CodingKeys: String, CodingKey {
////        case userID = "id"
////        case id = "id_review"
////        case title, body, rating
////        case idMovie = "id_movie"
////    }
//}
//
//class ApiUser: ObservableObject{
//    @Published var user = UserResponse()
//
//    func loadDataUser(completion:@escaping (UserResponse) -> ()) {
//        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getUser_username.php/info?username=accr0")
//        //guard let url = URL(string: "http://localhost/cinemates/getList_idUser.php/info?id=1")
//        else {
//            print("Invalid url...")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            self.user = try! JSONDecoder().decode(UserResponse.self, from: data!)
//            print(self.user)
//            DispatchQueue.main.async {
//                completion(self.user)
//            }
//        }.resume()
//
//    }
//}

