//
//  ResultViewController.swift
//  
//
//  Created by Manish Shukla on 4/18/18.
//

import UIKit

class ResultViewController: UITableViewController {
    
    private let reuseIdentifier = "Cell"
    var headers: String?
    var boxDocument: BoxDocument?
    var boxList: [BoxDocument]?
    
    var apiResponse: ApiResponse? {
        didSet {
            let apiHeaders = apiResponse?.headers
            headers = ((apiHeaders?.description)!)
            if (apiResponse?.boxDocument != nil)
            {
                boxDocument = apiResponse?.boxDocument
            }
            if(apiResponse?.boxListObject != nil)
            {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Result"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0
//        {
//            return self.apiResponse?.boxListObject?.listofBoxDocs!.count
//        }
//        else {
//            return self.apiResponse?.headers.count
//        }
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
            if ((self.apiResponse?.boxListObject?.listofBoxDocs) != nil)
            {
                return (self.apiResponse?.boxListObject?.listofBoxDocs!.count)!
            }
            else if ((self.apiResponse?.boxDocument) != nil)
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
//                let textString = "Key: " + (self.boxDocument?.key)! +
//                                        "\nValue: " + (self.boxDocument?.value)! +
//                                        "\nScope: " + (self.boxDocument?.scope)! +
//                                        " \nDevice ID: " + (self.boxDocument?.device_id)! +
//                                        "\nProduct ID: " + (self.boxDocument?.product_id)! +
//                                        "\nUpdated At: " + (self.boxDocument?.updated_at)!
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
