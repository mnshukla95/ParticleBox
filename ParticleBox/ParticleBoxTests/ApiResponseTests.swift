//
//  ApiResponseTests.swift
//  ParticleBoxTests
//
//  Created by Manish Shukla on 4/18/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import XCTest
import Quick
import Nimble

class ApiResponseTests: QuickSpec {
    
    override func spec()
    {
        var apiResponse: ApiResponse?
        
        describe("ApiResponseSpec")
        {
            beforeEach
                {
                    apiResponse = ApiResponse()
                    apiResponse!.boxListObject = BoxListObject()
                    apiResponse!.boxDocument = BoxDocument()
                    apiResponse!.statusCode = 200
                    apiResponse!.headers = ["accept":"application/json", "Content-Type":"application/json", "Authorization":"Bearer <access_token>"]
            }
            
            it("should show apiResponse is not nil")
            {
                expect(apiResponse!).notTo(beNil())
            }
            
            it("should show apiResponse can be assigned BoxListObject")
            {
                expect(apiResponse!.boxListObject).notTo(beNil())
            }
            
            it("should show apiResponse can be assigned BoxDocument")
            {
                expect(apiResponse!.boxDocument).notTo(beNil())
            }
            
            it("should show apiResponse can be assigned status code")
            {
                expect(apiResponse!.statusCode).to(equal(200))
            }
            
            it("should show apiResponse can be assigned headers")
            {
                expect(apiResponse!.headers["accept"]).to(equal("application/json"))
                expect(apiResponse!.headers["Content-Type"]).to(equal("application/json"))
                expect(apiResponse!.headers["Authorization"]).to(equal("Bearer <access_token>"))
            }
            
        }
    }
    
}
