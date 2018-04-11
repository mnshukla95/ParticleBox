//
//  ApiRequest.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit
import Alamofire

enum Result<T> {
    case success(T)
    case error
}

class ApiRequest
{
    
    func request(_ url: URL, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Any>) -> Void)
    {
        Alamofire.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).responseData { (response) in
                                do {
                    //                print(try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves))
                                    let boxDoc = try JSONDecoder().decode(BoxDocument.self, from: response.data!)
                    //                print(request)
                                    print(boxDoc)
                                } catch let jsonErr {
                                    print(jsonErr.localizedDescription)
                                }
        }
    }

}
