//
//  MovieName.swift
//  Cinemates
//
//  Created by Aldo Di Giovanni on 14/01/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
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

    func MovieNameResponseTask(with url: URL, completionHandler: @escaping (MovieNameResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
 
// MARK: - List
struct MovieNameResponse: Codable {
    let status: Int
    let movieNameLists: [MovieName]?
    init() {
        status = 1
        movieNameLists = []
    }
    enum CodingKeys: String, CodingKey {
            case status
            case movieNameLists = "info"
        }
}

struct IdToMovieNameResponse: Codable {
    let status: Int
    let name: String?
    init() {
        status = 1
        name = ""
    }
    enum CodingKeys: String, CodingKey {
            case status
            case name = "info"
        }
}

struct MovieName: Codable, Identifiable {
    let id: String
    
//    enum CodingKeys: String, CodingKey {
//        case id = "name"
//    }
    
}

class ApiMovieName : ObservableObject{
    @Published var movieNameResponse = IdToMovieNameResponse()
    
    func loadData(num: String, completion:@escaping (IdToMovieNameResponse?,Error?) -> ()) {
        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getMovieName_idMovie.php/info?id=\(num)")
        else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                self.movieNameResponse = try JSONDecoder().decode(IdToMovieNameResponse.self, from: data!)
                DispatchQueue.main.async {
                    completion(self.movieNameResponse,nil)
                }
            }
            //If the decode fail, return the empty movie name
            catch{
                DispatchQueue.main.async {
                    print("Failure, cause: \(error) from url: \(url)")
                    completion(nil,error)
                }
            }
        }.resume()
        
    }
}
