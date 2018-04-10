//
//  ApiRequest.swift
//  ParticleBoxTests
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Mockingjay

@testable import ParticleBox

class ApiRequestTests: QuickSpec {
    
    override func spec()
    {
        let object: JsonObject = [
            "key": "temperature",
            "value": 25,
            "scope": "device",
            "device_id": "250000000000000000000001",
            "product_id": 1234,
            "updated_at": "2016-08-29T09:12:33.001Z"
        ]
        
        describe("Api Request") {
            var apiRequest: ApiRequest!
            
            beforeEach {
                apiRequest = ApiRequest()
            }
            
            context("get") {
                
                it("should return json object when server response object is of type json object") {
                    self.stub(everything, json(object))
                    
                    var jsonResponse: JsonObject? = nil
                    
                    apiRequest.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
                        switch result {
                        case .success(.object (let response)):
                            jsonResponse = response
                        default:
                            fatalError()
                        }
                    })
                    
                    expect(jsonResponse).toEventuallyNot(beNil())
                    
                }
                
                it("should return a json of type array when server response is a array of json object") {
                    
                    let array = [object, object, object]
                    self.stub(everything, json(array))
                    
                    var jsonResponse: [JsonObject]? = nil
                    
                    apiRequest.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
                        switch result {
                        case .success(.array (let response)):
                            jsonResponse = response
                        default:
                            fatalError()
                        }
                    })
                    
                    expect(jsonResponse).toEventuallyNot(beNil())
                }
                
                it("should return a error when server response is not a json") {

                    let body = "[[]]"
                    let bodyData = body.data(using: String.Encoding.utf8)!

                    self.stub(everything, http(download: .content(bodyData)))

                    var errorResponse: Bool = false

                    apiRequest.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
                        switch result {
                        case .error:
                            errorResponse = true
                        default:
                            fatalError()
                        }
                    })

                    expect(errorResponse).toEventuallyNot(beTrue())
                }
                
                it("should return a error when server response is a error") {
                    
                    let error = NSError.init(domain: "testing", code: 0, userInfo: nil)
                    
                    self.stub(everything, failure(error))
                    
                    var errorResponse: Error? = nil
                    
                    apiRequest.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
                        switch result {
                        case .error:
                            errorResponse = error
                        default:
                            fatalError()
                        }
                    })
                    
                    expect(errorResponse).toEventuallyNot(beNil())
                    expect(errorResponse as NSError?).toEventually(equal(error))
                }
                
                it("should add the parameters on the url") {
                    
                    let parameters: [String: Any] = [ "project": "ParticleBox",
                                                      "name": "Testing"]
                    
                    var correctUrl = false
                    
                    let matcher = { (request: URLRequest) -> Bool in
                        correctUrl = request.url!.absoluteString == "http://www.google.com?name=Testing&project=ParticleBox"
                        return true
                    }
                    
                    self.stub(matcher, json(object))
                    
                    
                    apiRequest.request(URL(string: "http://www.google.com")!, method: .get, parameters: parameters, headers: nil, completion: { (result) in
                        
                    })
                    
                    expect(correctUrl).toEventually(beTrue())
                }
                
                it("should pass the headers") {
                    
                    let headers: [String: String] = [ "AppKey": "Particle",
                                                      "AppSecret": "Box"]
                    
                    var success = true
                    
                    let matcher = { (request: URLRequest) -> Bool in
                        for (key, value) in headers {
                            if request.allHTTPHeaderFields![key] != value {
                                success = false
                                break
                            }
                        }
                        return true
                    }
                    
                    self.stub(matcher , json(object))
                    
                    
                    apiRequest.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: headers, completion: { (result) in
                        
                    })
                    
                    expect(success).toEventually(beTrue())
                }
                
            }
            
            
        }
        
        
        
    }
    
}
