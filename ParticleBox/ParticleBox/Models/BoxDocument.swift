//
//  BoxDocument.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit
import ObjectMapper

class BoxDocument: Mappable
{
    var key: String?
    var value: String?
    var scope: String?
    var device_id: String?
    var product_id: Int?
    var updated_at: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        key <- map["key"]
        value <- map["value"]
        scope <- map["scope"]
        device_id <- map["device_id"]
        product_id <- map["product_id"]
        updated_at <- map["updated_at"]
    }
}
