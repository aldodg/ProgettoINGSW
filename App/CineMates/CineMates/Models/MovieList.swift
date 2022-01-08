//
//  list.swift
//  test
//
//  Created by Aldo Di Giovanni on 07/01/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
  
struct Welcome: Codable {
    let status: Int
    let info: [Info]
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


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

    func welcomeTask(with url: URL, completionHandler: @escaping (Welcome?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}



// MARK: - List
struct MovieList: Codable {
    let status: Int
    let info: [Info]
    init() {
        status = 1
        info = []
    }
}
// MARK: - Info
struct Info: Codable {
    let id, idList, listName, movies: String

    enum CodingKeys: String, CodingKey {
        case id
        case idList = "id_list"
        case listName = "list_name"
        case movies
    }
}

class Api : ObservableObject{
    @Published var list = MovieList()
    
    func loadData(completion:@escaping (MovieList) -> ()) {
        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getList_idUser.php/?id=1")
        //guard let url = URL(string: "http://localhost/cinemates/getList_idUser.php/info?id=1")
        else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.list = try! JSONDecoder().decode(MovieList.self, from: data!)
            print(self.list)
            DispatchQueue.main.async {
                completion(self.list)
            }
        }.resume()
        
    }
}
