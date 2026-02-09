//
//  CoreManager.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//

import Foundation
import Alamofire
class CoreManager {
    func request<T: Codable>(model: T.Type,
                             endpoint: String,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             encoding: EncodingType = .url,
                             completion: @escaping((T?, String?) -> Void)) {
        
        print("url: \(CoreHelper.shared.configureURL(endpoint: endpoint))")
        
        AF.request(CoreHelper.shared.configureURL(endpoint: endpoint),
                   method: method,
                   parameters: parameters,
                   encoding: encoding == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: CoreHelper.shared.headers).responseData { response in
            switch response.result {
            case .success(let data):
                print(String(data: data, encoding: .utf8))
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    print(result)
                    completion(result, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
