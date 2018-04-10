//
//  ApiRequest.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit
import Alamofire

typealias JsonObject = [String : Any]

enum Result<T> {
    case success(T)
    case error
}

/*
 
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Use Codable instead???
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 */

enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])

    init?(json:Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }

        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }

        return nil
    }
}

protocol NetworkRequest {
    func request(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String : Any]?,
        headers: [String: String]?,
        completion: @escaping(Result<Json>) -> Void)
        -> Void
}

class ApiRequest: NetworkRequest {
    
    func request(_ url: URL, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Json>) -> Void) {
        Alamofire.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON { (response) in
                            if let value = response.result.value, let result = Json(json: value) {
                                completion(.success(result))
                            }
                            else {
                                completion(.error)
                            }
        }
    }

}
