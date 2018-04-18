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
    
    var segments : SegmentedRow<String>?
    var delete_key_row : TextRow?
    var get_single_key_row : TextRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Request Setup"
        
        setupRequiredRows()
        setupUI()
    }
    
    func setupRequiredRows () {
        
        self.segments = SegmentedRow<String>("segments"){
            $0.options = ["GET (All)", "POST", "GET (Single)", "DELETE"]
            $0.value = "GET (All)"
            }.cellUpdate({ (cell, row) in
                cell.tintColor = .purple
            })
        
        self.get_single_key_row = TextRow(){ row in
            row.title = "Key"
            row.placeholder = "---"
            row.tag = "get_single_key"
        }
        
        self.delete_key_row = TextRow(){ row in
            row.title = "Key"
            row.placeholder = "---"
            row.tag = "delete_key"
        }
    }
    
    func setupUI() {
        form = Section("Method")
            <<< self.segments!
            
            +++ Section(){
                $0.tag = "GET (All)"
                $0.hidden = "$segments != 'GET (All)'"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                $0.tag = "get_all_scope"
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
                $0.tag = "get_all_device_id"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
                row.tag = "get_all_product_id"
            }
            
            <<< TextRow(){ row in
                row.title = "Filter"
                row.placeholder = "---"
                row.tag = "get_all_filter"
            }
            
            <<< IntRow() {
                $0.title = "Page"
                $0.placeholder = "---"
                $0.tag = "get_all_page"
            }
            
            <<< IntRow() {
                $0.title = "Per Page"
                $0.placeholder = "---"
                $0.tag = "get_all_per_page"
            }
            
            +++ Section(){
                $0.tag = "POST"
                $0.hidden = "$segments != 'POST'"
            }
            
            <<< TextRow(){ row in
                row.title = "Key"
                row.placeholder = "---"
                row.tag = "post_key"
            }
            
            <<< IntRow() {
                $0.title = "Value"
                $0.placeholder = "---"
                $0.tag = "post_value"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                $0.tag = "post_scope"
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
                $0.tag = "post_device_id"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
                row.tag = "post_product_id"
            }
            
            +++ Section(){
                $0.tag = "GET (Single)"
                $0.hidden = "$segments != 'GET (Single)'"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                $0.tag = "get_single_scope"
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
                $0.tag = "get_single_device_id"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
                row.tag = "get_single_product_id"
            }
            
            <<< self.get_single_key_row!
            
            +++ Section(){
                $0.tag = "DELETE"
                $0.hidden = "$segments != 'DELETE'"
            }
            
            <<< AlertRow<String>() {
                $0.title = "Scope"
                $0.cancelTitle = "Dismiss"
                $0.options = ["Device", "User", "Product"]
                $0.value = ""
                $0.tag = "delete_scope"
                }.onChange { row in
                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purple
            }
            
            <<< IntRow() {
                $0.title = "Device ID"
                $0.placeholder = "---"
                $0.tag = "delete_device_id"
            }
            
            <<< TextRow(){ row in
                row.title = "Product ID"
                row.placeholder = "---"
                row.tag = "delete_product_id"
            }
            
            <<< self.delete_key_row!
            
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Submit"
                }.cellUpdate({ (cell, row) in
                    cell.backgroundColor = .purple
                    cell.textLabel?.textColor = .white
                }).onCellSelection { [weak self] (cell, row) in
                    let segment = self?.segments?.value!
                    if ((segment == "DELETE" && self?.delete_key_row?.value == nil) ||
                        (segment == "GET (Single)" && self?.get_single_key_row?.value == nil))
                    {
                        let alert = UIAlertController(title: "Alert", message: "Key field must be filled!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.view.tintColor = .purple
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            switch action.style{
                            case .default:
                                print("default")
                                
                            case .cancel:
                                print("cancel")
                                
                            case .destructive:
                                print("destructive")
                            }}))
                        self?.present(alert, animated: true, completion: nil)
                        
                    }
                    else {
                        let vals = self?.form.values()
                        let method = vals!["segments"] as! String
                        let parameters = self?.switchKeys(dict: vals!)
                        self?.pushVC(parameters: parameters!, method: method)
                    }
        }
    }
    
    func switchKeys(dict: [String:Any?]) -> [String:Any?]
    {
        let keys = dict.keys
        var parameters = [String:Any]()
        
        for key in keys{
            switch key {
            case "post_key", "get_single_key", "delete_key":
                parameters["key"] = dict[key] ?? nil
            case "post_value":
                parameters["value"] = dict[key] ?? nil
            case "get_all_scope", "get_single_scope", "delete_scope", "post_scope":
                parameters["scope"] = dict[key] ?? nil
            case "get_all_product_id", "get_single_product_id", "delete_product_id", "post_product_id":
                parameters["product_id"] = dict[key] ?? nil
            case "get_all_device_id", "get_single_device_id", "delete_device_id", "post_device_id":
                parameters["device_id"] = dict[key] ?? nil
            case "get_all_filter":
                parameters["filter"] = dict[key] ?? nil
            case "get_all_page":
                parameters["page"] = dict[key] ?? nil
            case "get_all_per_page":
                parameters["per_page"] = dict[key] ?? nil
            default:
                break
            }
        }
        return parameters
    }
    
    
    func pushVC(parameters: [String:Any?], method: String)
    {
        print(method)
        //let vals = form.values()
        //let dict = switchKeys(dict: vals)
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

