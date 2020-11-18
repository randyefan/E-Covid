//
//  NetworkManager.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 17/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

enum APIError: String {
    case networkError
    case apiError
    case decodingError
}

enum APIs: URLRequestConvertible {
    
    // MARK: - case containing api
    case statsByProvince
    case day
    
    // MARK: - Variables
    static let endpoint = URL(string: "https://data.covid19.go.id/public/api")!
    
    var path: String {
        switch self {
        case .statsByProvince:
            return "/prov.json"
        case .day:
            return "/update.json"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: URLEncoding {
        return URLEncoding.init(destination: .methodDependent, arrayEncoding: .noBrackets)
    }
    
    func asURLRequest() throws -> URLRequest {
        let request = URLRequest(url: Self.endpoint.appendingPathComponent(path))
        return request
    }
}

struct NetworkManager {
    let jsonDecoder = JSONDecoder()
    
    func getStatsByProvince(completion: @escaping(JSON?, APIError?) -> ()) {
        Alamofire.request(APIs.statsByProvince).validate().responseJSON { json in
            switch json.result {
            case .failure:
                completion(nil, .apiError)
                break
            case .success(let jsonData):
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys) {
                    do {
                        let data = try JSON(data: jsonData)
                        completion(data, nil)
                    } catch {
                        print(error)
                        completion(nil, .decodingError)
                    }
                } else {
                    completion(nil, .networkError)
                }
            }
        }
    }
    
    func getStatsIndonesian(completion: @escaping(JSON?, APIError?) -> ()) {
        Alamofire.request(APIs.day).validate().responseJSON { json in
            switch json.result {
            case .failure:
                completion(nil, .apiError)
                break
            case .success(let jsonData):
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys) {
                    do {
                        let data = try JSON(data: jsonData)
                        completion(data, nil)
                    } catch {
                        print(error)
                        completion(nil, .decodingError)
                    }
                } else {
                    completion(nil, .networkError)
                }
            }
        }
    }
}
