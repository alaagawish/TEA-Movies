//
//  NetworkManager.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 03/07/2025.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getRequest<T: Decodable>(url: String, token: String, responseType: T.Type, handler: @escaping (T?) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(
            "\(Constants.BaseURL)" + url,
            method: .get,
            headers: headers)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                print("Done: \("\(Constants.BaseURL)" + url)")
                handler(data)
            case .failure(let error):
                print("Error in \("\(Constants.BaseURL)" + url): \(error)")
                handler(nil)
            }
        }
    }
    func postRequest<T: Decodable>(url: String, token: String, parameters: [String: Any], responseType: T.Type, handler: @escaping (T?) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(
            "\(Constants.BaseURL)" + url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                print("Done: \(url)")
                handler(data)
            case .failure(let error):
                print("Error in \(url): \(error)")
                handler(nil)
            }
        }
    }
}
