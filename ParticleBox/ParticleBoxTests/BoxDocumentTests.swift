//
//  BoxDocumentTests.swift
//  ParticleBoxTests
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import ParticleBox

class BoxDocumentTests: QuickSpec
{
    
    override func spec()
    {
        var boxDoc: BoxDocument?
        
        describe("BoxDocumentSpec")
        {
            
            beforeEach
            {
                
                boxDoc = BoxDocument(key: "temperature", value: "25")
                boxDoc!.scope = "product"
                boxDoc!.device_id = "250000000001"
                boxDoc!.product_id = 1234
                boxDoc!.updated_at = "2016-08-29T09:12:33.001Z"
                
            }
            
            it("should show boxDoc is not nil")
            {
                expect(boxDoc!).notTo(beNil())
            }
            
            it("should show boxDoc can be assigned key and value")
            {
                expect(boxDoc!.key).to(equal("temperature"))
                expect(boxDoc!.value).to(equal("25"))
            }
            
            it("should show boxDoc can be assigned scope")
            {
                expect(boxDoc!.scope).to(equal("product"))
            }
            
            it("should show boxDoc can be assigned device_id")
            {
                expect(boxDoc!.device_id).to(equal("250000000001"))
            }
            
            it("should show boxDoc can be assigned product_id")
            {
                expect(boxDoc!.product_id).to(equal(1234))
            }
            
            it("should show boxDoc can be assigned updated_at")
            {
                expect(boxDoc!.updated_at).to(equal("2016-08-29T09:12:33.001Z"))
            }
        }
        
    }
    
}
