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
    let movieNameLists: String
    init() {
        status = 1
        movieNameLists = ""
    }
    enum CodingKeys: String, CodingKey {
            case status
            case movieNameLists = "info"
        }
}

class ApiMovieName : ObservableObject{
    @Published var movieName = MovieNameResponse()
    
    func loadData(num: String, completion:@escaping (MovieNameResponse) -> ()) {
        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getMovieName_idMovie.php/info?id=\(num)")
        else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.movieName = try! JSONDecoder().decode(MovieNameResponse.self, from: data!)
            print(self.movieName)
            DispatchQueue.main.async {
                completion(self.movieName)
            }
        }.resume()
        
    }
}
