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
//import Mockingjay

@testable import ParticleBox

class ApiRequestTests: QuickSpec
{
    override func spec()
    {
        
        let parameters : [String : Any] =
        [
            "scope":"device",
            "device_id":"250000000000000000000001",
            "product_id":1234
        ]
        
        let headers : [String : Any] = ["accept":"application/json", "Content-Type":"application/json"]
        
        
        describe("Api Request")
        {
            var apiRequest: ApiRequest!
            
            beforeEach
            {
                apiRequest = ApiRequest()
            }
            
            context("get")
            {
                
                it("should return object that conforms to ApiResponse")
                {
                    self.stub(everything, json(object))
                    
                    let urlString = Config.baseUrl + "/temperature"
                    guard let url = URL(string: urlString) else {return}
                    
                    var apiResponse: ApiResponse? = nil
                    apiRequest.getSingleBox(key: key, parameters: dict) { (response) in
                        apiResponse = response
                    }
                    expect(apiResponse).toEventuallyNot(beNil())
                }
                
                it("should return an object that conforms to the BoxDocument object")
                {
                    self.stub(everything, json(object))
                    
                    let urlString = Config.baseUrl + "/temperature"
                    guard let url = URL(string: urlString) else {return}

                    var apiResponse: ApiResponse? = nil
                    var boxDoc: BoxDocument? = nil
                    
                    apiRequest.postBoxDoc(parameters: dict) { (response) in
                        apiResponse = response
                        boxDoc = apiResponse?.boxDocument
                    }
                    expect(boxDoc).toEventuallyNot(beNil())
                }
                
                it("should return an object that conforms to the BoxListObject object")
                {
                    self.stub(everything, json(object))
                    
                    let urlString = Config.baseUrl
                    guard let url = URL(string: urlString) else {return}
                    
                    var apiResponse: ApiResponse? = nil
                    var boxListObj: BoxListObject? = nil
                    
                    apiRequest.getBoxList(parameters: dict) { (response) in
                        apiResponse = response
                        boxListObj = apiResponse?.boxListObject
                    }
                    expect(boxListObj).toEventuallyNot(beNil())
                }
                
                it("should return a status code")
                {
                    self.stub(everything, json(object))
                    
                    let urlString = Config.baseUrl
                    guard let url = URL(string: urlString) else {return}
                    
                    var apiResponse: ApiResponse? = nil
                    var status: Int? = nil
                    
                    apiRequest.getBoxList(parameters: dict) { (response) in
                        apiResponse = response
                        status = apiResponse?.statusCode
                    }
                    expect(status).toEventuallyNot(beNil())
                }
                
                it("should include parameters in the URL") {
                    
                    var correctUrl = false
                    
                    let matcher = { (request: URLRequest) -> Bool in
                        correctUrl = request.url!.absoluteString == "https://virtserver.swaggerhub.com/particle-iot/box/0.1/box?scope=device&device_id=250000000000000000000001&product_id=1234&per_page=10"
                        return true
                    }
                    
                    self.stub(matcher, json(object))
                    
                    
                    apiRequest.getBoxList(parameters: parameters, callback: { (response) in
                        
                    })

                    expect(correctUrl).toEventually(beTrue())
                }
                
            }
            
        }
        
        
        
    }
    
}
