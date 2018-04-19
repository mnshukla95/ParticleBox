//
//  ResultViewController.swift
//  
//
//  Created by Manish Shukla on 4/16/18.
//

import UIKit

class ResultViewController: UITableViewController {
    
    private let reuseIdentifier = "Cell"
    var headers: String?
    var status: Int?
    var boxDocument: BoxDocument?
    var boxListObject: BoxListObject?
    
    var apiResponse: ApiResponse? {
        didSet {
            status = apiResponse?.statusCode
            let apiHeaders = apiResponse?.headers
            headers = ((apiHeaders?.description)!)
            if (apiResponse?.boxDocument != nil)
            {
                boxDocument = apiResponse?.boxDocument
            }
            if(apiResponse?.boxListObject != nil)
            {
                boxListObject = apiResponse?.boxListObject
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = String("Status: \(self.status!)")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "JSON Response"
        }
        else {
            return "Headers"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            if ((self.boxListObject) != nil)
            {
                return (self.boxListObject?.listofBoxDocs?.count)!
            }
            else if ((self.boxDocument) != nil)
            {
                return 1
            }
            else {
                return 0
            }
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!

        if indexPath.section == 0
        {
            if (boxDocument != nil)
            {
                let textString = String(format: "Key: \((self.boxDocument?.key)!)\nValue: \((self.boxDocument?.value)!)\nScope: \((self.boxDocument?.scope)!)\nDevice ID: \((self.boxDocument?.device_id)!)\nProduct ID: \((self.boxDocument?.product_id)!)\nUpdated At: \((self.boxDocument?.updated_at)!)")
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = textString
            }
            if (boxListObject != nil)
            {
                let boxDocument = self.boxListObject?.listofBoxDocs![indexPath.row]
                let textString = String(format: "Key: \((boxDocument?.key)!)\nValue: \((boxDocument?.value)!)\nScope: \((boxDocument?.scope)!)\nDevice ID: \((boxDocument?.device_id)!)\nProduct ID: \((boxDocument?.product_id)!)\nUpdated At: \((boxDocument?.updated_at)!)")
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = textString
            }
        }
        
        if indexPath.section == 1
        {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = headers
        }

        return cell
    }

}
