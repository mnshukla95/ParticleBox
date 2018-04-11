//
//  ApiResponseObject.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/10/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import Foundation

struct ApiResponseObject
{
    let meta: [String : Any]
    let data: [[String : Any]]
    
    init(meta: [String:Any], data: [[String:Any]])
    {
        self.meta = meta
        self.data = data
    }
    
}
