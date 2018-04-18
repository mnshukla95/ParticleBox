//
//  ResultViewController.swift
//  ParticleBox
//
//  Created by Manish Shukla on 4/16/18.
//  Copyright © 2018 Manish Shukla. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var parameters: [String:Any]? {
        didSet {
            let method = parameters!["method"] as! String
            print(method)
            parameters?.removeValue(forKey: "method")
            print(parameters!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Result"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
