//
//  ApiResponse.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/12/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import Foundation

struct ApiResponse
{
    var boxListObject: BoxListObject?
    var boxDocument: BoxDocument?
    let statusCode: Int
    let headers: [String: String]
    
    init(status: Int, headers: [String:String])
    {
        self.statusCode = status
        self.headers = headers
    }
}
