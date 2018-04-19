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
        self.requestHeaders["Authorization"] = keychain["swaggerhub-token"]
        self.requestHeaders["accept"] = "application/json"
        self.requestHeaders["Content-Type"] = "application/json"
    }
    
    
    
    func getSingleBox(key: String, parameters: [String : Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        let url = URL(string: String(Config.baseUrl + "/\(key)"))!
        
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
    
    func getBoxList(parameters: [String : Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        let url = URL(string: Config.baseUrl)!

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
    
    func postBoxDoc(parameters: [String:Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        let url = URL(string: Config.baseUrl)!
        
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
    
    func deleteBoxDoc(key: String, parameters: [String:Any]?, callback:@escaping ((ApiResponse) -> Void))
    {
        let url = URL(string: String(Config.baseUrl + "/\(key)"))!
        
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
