//
//  HttpRequest.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/10/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit
import Alamofire

class HTTP: NSObject {
    
    
    let alamofireManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    let endpointBaseUrl = "https://www.virtserver.swaggerhub.com/particle-iot/box/0.1"
    
    func get(_ path: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> DataRequest {
        let baseUrl = URL(string: endpointBaseUrl)
        let url = URL(string: path, relativeTo: baseUrl)!
        let finalHeaders = withAuth(headers: headers)
        return alamofireManager.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: finalHeaders)
    }
    
    func post(_ path: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> DataRequest {
        let baseUrl = URL(string: endpointBaseUrl)
        let url = URL(string: path, relativeTo: baseUrl)!
        let finalHeaders = withAuth(headers: headers)
        return alamofireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: finalHeaders)
    }
    
    func put(_ path: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> DataRequest {
        let baseUrl = URL(string: endpointBaseUrl)
        let url = URL(string: path, relativeTo: baseUrl)!
        let finalHeaders = withAuth(headers: headers)
        return alamofireManager.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: finalHeaders)
    }
    
    func patch(_ path: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> DataRequest {
        let baseUrl = URL(string: endpointBaseUrl)
        let url = URL(string: path, relativeTo: baseUrl)!
        let finalHeaders = withAuth(headers: headers)
        return alamofireManager.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: finalHeaders)
    }
    
    func delete(_ path: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> DataRequest {
        let baseUrl = URL(string: endpointBaseUrl)
        let url = URL(string: path, relativeTo: baseUrl)!
        let finalHeaders = withAuth(headers: headers)
        return alamofireManager.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: finalHeaders)
    }
    
    func upload(_ path: String, fileUrl: URL, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> UploadRequest {
        let baseUrl = URL(string: endpointBaseUrl)
        let url = URL(string: path, relativeTo: baseUrl)!
        let headers = withAuth(headers: headers)
        let request = URLRequest(url: url)
        let encodedUrl = try! Alamofire.URLEncoding(destination: .queryString).encode(request, with: parameters).asURLRequest().url!
        return alamofireManager.upload(fileUrl, to: encodedUrl, method: .post, headers: headers)
    }
    
    private func withAuth(headers: [String: String]?) -> [String: String]? {
        var mutableHeaders: [String: String] = headers ?? [:]
            //access_token should be stored in SSKeychain
            mutableHeaders["Authorization"] = "Bearer <access_token>"
        return mutableHeaders
    }
}
