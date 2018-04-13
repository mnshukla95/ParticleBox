//
//  ViewController.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = ApiRequest()
//        let url = URL(string: String(Config.baseUrl + "/temperature"))
        let url = URL(string: String(Config.baseUrl))

        
//        let parameters: [String : Any] = [
//            "scope":"device",
//            "device_id":"250000000000000000000001",
//            "product_id":1234,
//            "filter":"temperature",
//            "page":0,
//            "per_page":10f
//        ]
        
//        let parameters: [String : Any] = [
//            "scope":"device",
//            "device_id":"250000000000000000000001",
//            "product_id":1234,
//            "key":"temperature",
//            "value":"25",
//        ]
        
        //2016-08-29T09:12:33.001Z
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:SS.sss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let myString = formatter.string(from: Date())
        print(myString)
        
        let parameters: [String : Any] = [
            "scope":"device",
            "device_id":"250000000000000000000001",
            "product_id":1234,
            "key":"temperature"
            ]
        
//        let parameters: [String : Any] = [
//            "scope":"device",
//            "device_id":"250000000000000000000001",
//            "product_id":1234,
//            "filter":"temperature",
//            "page":0,
//            "per_page":10
//        ]
        
//        api.requestBoxList(url!, parameters: parameters) { (response) in
//            let boxes = response.boxListObject!.listofBoxDocs!
//            for box in boxes{
//                print(box.device_id!)
//            }
//        }

        api.deleteBoxDoc(url!, parameters: parameters) { (response) in
            print(response.headers)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

