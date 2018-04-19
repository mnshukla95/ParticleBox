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
        
        let headers : [String : Any] = ["accept":"application/json"]
        
        
        describe("Api Request")
        {
            var apiRequest: ApiRequest!
            
            beforeEach
            {
                apiRequest = ApiRequest()
            }
            
            context("get")
            {
                
                it("should return json object when server response object is of type json object")
                {
//                    self.stub(everything)
                    
                    let urlString = Config.baseUrl + "/temperature"
                    guard let url = URL(string: urlString) else {return}
                    
                    var bd: BoxDocument? = nil
                    
                    var apiRequest = ApiRequest()
                    apiRequest.request(url, method: .get, parameters: parameters, headers: ["accept":"application/json"]) { (response) in
                        bd = BoxDocument(key: "temp", value: "temp")
                    }
                    
                    expect(bd).toEventuallyNot(beNil())
                    
                }
                
            }
            
            context("put")
            {
                
            }
            
            context("delete")
            {
                
            }
            
            
        }
        
        
        
    }
    
}
