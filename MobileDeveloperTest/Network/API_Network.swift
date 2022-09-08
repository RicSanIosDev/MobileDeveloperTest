//
//  API_Network.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import Foundation
import UIKit

enum APIError: Error {
    case unknown
    case emptyData
    case notConnection
    case mapError
}


class API_Network {
    let urlAPI = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"

    static let shared: API_Network = API_Network()
    let localRepo = LocalRepository()

    func getPost( completion: @escaping (Result<[PostModel], APIError>) -> Void)  {
        let session = URLSession.shared


        guard let url = URL(string: urlAPI) else {

                completion(.failure(.notConnection))
                 return
             }

             let task = session.dataTask(with: url) {(data, urlResponse, error) in
                 if let error = error {
                     print("Ocurred Error: \(error.localizedDescription)")
                     completion(.failure(.unknown))
                     return
                 }

                 guard let data = data else {
                     print("Empty Data")
                     completion(.failure(.emptyData))
                     return
                 }

                 do {
                     let postResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                     let post = PostMapper.map(responses: postResponse)
                     completion(.success(post))
                 } catch let error {
                     print(error.localizedDescription)
                     completion(.failure(.mapError))
                 }
             }; task.resume()
    }
}
