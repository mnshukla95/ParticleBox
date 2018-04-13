//
//  ApiRequest.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import KeychainAccess

class ApiRequest
{
    var requestHeaders = [String:String]()

    init()
    {
        let keychain = Keychain(service: "com.virtserver.swaggerhub-token")
        self.requestHeaders["accept"] = "application/json"
        self.requestHeaders["Content-Type"] = "application/json"
        self.requestHeaders["Authorization"] = keychain["swaggerhub-token"]
    }
    
    
    func getSingleBox(_ url: URL, parameters: [String : Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: requestHeaders).responseObject { (response: DataResponse<BoxDocument>) in
                            let boxDocument = response.result.value
                            let headers = response.request?.allHTTPHeaderFields!
                            let status = response.response?.statusCode
                            var apiObject = ApiResponse(status: status!, headers: headers!)
                            apiObject.boxDocument = boxDocument!
                            callback(apiObject)
        }
    }
    
    func getBoxList(_ url: URL, parameters: [String : Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: requestHeaders).responseObject { (response: DataResponse<BoxListObject>) in
                            let boxListObject = response.result.value
                            let headers = response.request?.allHTTPHeaderFields!
                            let status = response.response?.statusCode
                            var apiObject = ApiResponse(status: status!, headers: headers!)
                            apiObject.boxListObject = boxListObject!
                            callback(apiObject)
        }
    }
    
    func postBoxDoc(_ url: URL, parameters: [String:Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        Alamofire.request(url,
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default,
                        headers: requestHeaders).response { (response) in
                            let headers = response.request?.allHTTPHeaderFields!
                            let status = response.response?.statusCode
                            let apiObject = ApiResponse(status: status!, headers: headers!)
                            callback(apiObject)
        }
    }
    
    func deleteBoxDoc(_ url: URL, parameters: [String:Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        Alamofire.request(url,
                          method: .delete,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: requestHeaders).response { (response) in
                            let headers = response.request?.allHTTPHeaderFields!
                            let status = response.response?.statusCode
                            let apiObject = ApiResponse(status: status!, headers: headers!)
                            callback(apiObject)
        }
    }

}
