//
//  APIClient.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 09.02.26.
//
import Alamofire

final class APIClient {

    static let shared = APIClient()
    private init() {}

    func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        let url = CoreHelper.shared.configureURL(endpoint: endpoint.path)

        AF.request(
            url,
            method: .get,
            parameters: endpoint.parameters,
            headers: CoreHelper.shared.headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
