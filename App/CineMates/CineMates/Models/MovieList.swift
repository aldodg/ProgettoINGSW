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
  /*
struct UserMovieListResponse: Codable {
    let status: Int
    let info: [Info]
}*/

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

    func UserMovieListResponseTask(with url: URL, completionHandler: @escaping (UserMovieListResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}



// MARK: - List
struct UserMovieListResponse: Codable {
    let status: Int
    let movieLists: [MovieList]
    init() {
        status = 1
        movieLists = []
    }
    enum CodingKeys: String, CodingKey {
            case status
            case movieLists = "info"
        }
}
// MARK: - Info
struct MovieList: Codable,Identifiable {
    let userID, id, listName: String
        let movies: [MovieID]

        enum CodingKeys: String, CodingKey {
            case userID = "id"
            case id = "id_list"
            case listName = "list_name"
            case movies
        }
}

struct MovieID: Codable,Identifiable {
    let id: String
}

class ApiList : ObservableObject{
    @Published var list = UserMovieListResponse()
//    @Published var name : String  = ""
//    @Published var data : String  = ""
    
    func loadData(num: String, completion:@escaping (UserMovieListResponse,Error?) -> ()) {
        
//        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getList_idUser.php/?id=1")
        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getList_idUser.php/?id=\(num)")
        //guard let url = URL(string: "http://localhost/cinemates/getList_idUser.php/info?id=1")
        else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                self.list = try JSONDecoder().decode(UserMovieListResponse.self, from: data!)
                print(self.list)
                DispatchQueue.main.async {
                    completion(self.list,nil)
                }
            }
            catch{
                completion(UserMovieListResponse(),error)
            }
        }.resume()
        
    }
    
//    func MovieName_idMovie (movieID: String) {
//
//        print("xxxx\(movieID)xxx")
//        guard let url = URL(string: "http://ec2-3-250-182-218.eu-west-1.compute.amazonaws.com/getMovieName_idMovie.php/info?id=\(movieID)")
//        else {
//            print("Invalid url...")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            let stringData = data! as! String
//            print ("\(stringData)")
//        }.resume()
//
//    }
}
