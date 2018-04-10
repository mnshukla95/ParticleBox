//
//  BoxDocument.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit

struct BoxDocument {
    //
    let key: String
    let value: String
    var scope: String?
    var device_id: String?
    var product_id: Int?
    var updated_at: String?
    
    init(key: String, value: String)
    {
        self.key = key
        self.value = value
    }
    
}
