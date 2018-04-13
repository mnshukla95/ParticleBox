//
//  ApiResponseObject.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/10/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import Foundation
import ObjectMapper

class BoxListObject: Mappable
{
    var page: Int?
    var per_page: Int?
    var total: Int?
    var listofBoxDocs: [BoxDocument]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page <- map["meta.page"]
        per_page <- map["meta.per_page"]
        total <- map["meta.total"]
        listofBoxDocs <- map["data"]
        
    }
    
}
