//
//  BoxListObjectTests.swift
//  ParticleBoxTests
//
//  Created by Manish Shukla on 4/18/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import XCTest
import Quick
import Nimble

class BoxListObjectTests: QuickSpec {
    
    override func spec()
    {
        var boxListObject: BoxListObject?
        
        describe("BoxListObjectSpec")
        {
            
            beforeEach
                {
                    boxListObject = BoxListObject()
                    let boxDocs = [BoxDocument(), BoxDocument(), BoxDocument()]
                    boxListObject!.listofBoxDocs = boxDocs
                    boxListObject!.page = 10
                    boxListObject!.per_page = 15
                    boxListObject!.total = 20
            }
            
            it("should show boxListObject is not nil")
            {
                expect(boxListObject!).notTo(beNil())
            }
            
            it("should show boxListObject has array of 3 BoxDocuments")
            {
                expect(boxListObject!.listofBoxDocs.count).to(equal(3))
            }
            
            it("should show boxListObject can be assigned page")
            {
                expect(boxListObject!.page).to(equal(10))
            }
            
            it("should show boxListObject can be assigned device_id")
            {
                expect(boxListObject!.per_page).to(equal(15))
            }
            
            it("should show boxListObject can be assigned total")
            {
                expect(boxListObject!.total).to(equal(20))
            }
            
        }
        
    }
    
}
