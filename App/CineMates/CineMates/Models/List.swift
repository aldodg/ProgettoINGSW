////
////  List.swift
////  CineMates
////
////  Created by Aldo Di Giovanni on 07/01/22.
////  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
////
//
//import Foundation
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
////
//// To read values from URLs:
////
////   let task = URLSession.shared.welcomeTask(with: url) { welcome, response, error in
////     if let welcome = welcome {
////       ...
////     }
////   }
////   task.resume()
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let status: Int
//    let info: [Info]
//}
//
////
//// To read values from URLs:
////
////   let task = URLSession.shared.infoTask(with: url) { info, response, error in
////     if let info = info {
////       ...
////     }
////   }
////   task.resume()
//
//// MARK: - Info
//struct Info: Codable {
//    let id, idList, listName, movies: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case idList = "id_list"
//        case listName = "list_name"
//        case movies
//    }
//}
//
//// MARK: - Helper functions for creating encoders and decoders
//
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
//
//// MARK: - URLSession response handlers
//
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
//    func welcomeTask(with url: URL, completionHandler: @escaping (Welcome?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//}
