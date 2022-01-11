////
////  UserComplete.swift
////  CineMates
////
////  Created by Aldo Di Giovanni on 06/01/22.
////  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
////
//
import Foundation


struct Query: Codable {
    let results: [Informations]
    
    enum CodingKeys: String, CodingKey {
        case results = "info"
    }
}



//// MARK: - Info
struct Informations: Codable, Identifiable {
    let id, idList, listName, movies: String
    let username, idReview, title, body: String
    let rating, idMovie: String

    enum CodingKeys: String, CodingKey {
        case id
        case idList = "id_list"
        case listName = "list_name"
        case movies, username
        case idReview = "id_review"
        case title, body, rating
        case idMovie = "id_movie"
    }
}
class Loader: ObservableObject {
    
//    @Published var list = List()
    // this is unneccassry as you're passing the list object back to the caller via the completion param
    
    func loadData(from urlString: String, completion: @escaping ([Informations]?) -> Void) {
        
        // transform urlString to URL
        guard let url = URL(string: urlString) else {
            fatalError("List.swift: Error transforming urlString to URL!")
                // this will force crash app and output the error in debugger
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //check server response. if bad, crash app with message
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("List.swift > Api.loadData: DataTask error: Bad server response!")
            }
            
            //if error, crash app with message
            if let error = error {
                fatalError("List.swift > Api.loadData: DataTask error: \(error.localizedDescription)!")
            }
            
            //if data is nil, crash app with message
            guard let data = data else {
                fatalError("List.swift > Api.loadData: DataTask error: data is nil!)")
            }
            
            // if no error, response.statusCode == 200, and we have data, then parse json
            
            //parse json, catch error
            do {
                
                let decoder = JSONDecoder()
                let list = try decoder.decode(Query.self, from: data)
                
                //pass list back to caller
                print("List.swift > Api.loadData: JSON Data successfully fetched and parsed! List object: \(list)")
                completion(list.results)
                
            // cath parsing error with custom message
            } catch {
                fatalError("List.swift > Api.loadData: Failed to parse JSON data!\n\(data.count)")
            }
            
        }.resume()
    }
}
