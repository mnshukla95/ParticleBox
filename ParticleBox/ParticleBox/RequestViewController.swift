//
//  ViewController.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/9/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit
import Eureka

class RequestViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Request Setup"
        
        form = Section("Method")
            <<< SegmentedRow<String>("segments"){
                $0.options = ["GET (Single)", "POST", "GET (All)", "DELETE"]
                $0.value = "GET (Single)"
                }.cellUpdate({ (cell, row) in
                    cell.tintColor = .purple
            })
            
            +++ Section(){
                $0.tag = "get_single"
                $0.hidden = "$segments != 'GET (Single)'"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Filter"
                row.placeholder = "---"
            }

            <<< IntRow() {
                $0.title = "Page"
                $0.placeholder = "---"
            }
            
            <<< IntRow() {
                $0.title = "Per Page"
                $0.placeholder = "---"
            }
            
            +++ Section(){
                $0.tag = "post"
                $0.hidden = "$segments != 'POST'"
            }
            
            <<< TextRow(){ row in
                row.title = "Key"
                row.placeholder = "---"
            }
            
            <<< IntRow() {
                $0.title = "Value"
                $0.placeholder = "---"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
            }
            
            +++ Section(){
                $0.tag = "get_all"
                $0.hidden = "$segments != 'GET (All)'"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Key"
                row.placeholder = "---"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            +++ Section(){
                $0.tag = "delete"
                $0.hidden = "$segments != 'DELETE'"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
            }
            
            <<< TextRow(){ row in
                row.title = "Key"
                row.placeholder = "---"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
        
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Submit"
                }.cellUpdate({ (cell, row) in
                    cell.backgroundColor = .purple
                    cell.textLabel?.textColor = .white
                }).onCellSelection { [weak self] (cell, row) in
                    self?.pushVC()
            }
    }
    
    func pushVC()
    {
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        transition.type = kCATransitionMoveIn
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(ResultViewController(), animated: false)
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let api = ApiRequest()
////        let url = URL(string: String(Config.baseUrl + "/temperature"))
//        let url = URL(string: String(Config.baseUrl))
//
//
////        let parameters: [String : Any] = [
////            "scope":"device",
////            "device_id":"250000000000000000000001",
////            "product_id":1234,
////            "filter":"temperature",
////            "page":0,
////            "per_page":10f
////        ]
//
////        let parameters: [String : Any] = [
////            "scope":"device",
////            "device_id":"250000000000000000000001",
////            "product_id":1234,
////            "key":"temperature",
////            "value":"25",
////        ]
//
//        //2016-08-29T09:12:33.001Z
//
//        let formatter = DateFormatter()
//        // initially set the format based on your datepicker date
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:SS.sss"
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        let myString = formatter.string(from: Date())
//        print(myString)
//
//        let parameters: [String : Any] = [
//            "scope":"device",
//            "device_id":"250000000000000000000001",
//            "product_id":1234,
//            "key":"temperature"
//            ]
//
////        let parameters: [String : Any] = [
////            "scope":"device",
////            "device_id":"250000000000000000000001",
////            "product_id":1234,
////            "filter":"temperature",
////            "page":0,
////            "per_page":10
////        ]
//
////        api.requestBoxList(url!, parameters: parameters) { (response) in
////            let boxes = response.boxListObject!.listofBoxDocs!
////            for box in boxes{
////                print(box.device_id!)
////            }
////        }
//
//        api.deleteBoxDoc(url!, parameters: parameters) { (response) in
//            print(response.headers)
//        }
//
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

