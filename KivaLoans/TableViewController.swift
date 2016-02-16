//
//  TableViewController.swift
//  
//
//  Created by Paul Lozada on 2016-02-15.
//
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    Alamofire.request(.GET, "http://api.kivaws.org/v1/loans/newest.json", parameters: nil).responseJSON(options: NSJSONReadingOptions.MutableContainers) { response in
        
        if let jsonResponse = response.data {
            do {
                let jsonSerialization = try NSJSONSerialization.JSONObjectWithData(jsonResponse, options: .MutableContainers)
                let loans = jsonSerialization["loans"] as! [AnyObject]
                
                for jsonLoans in loans {
                    let loan = Json()
                    loan.name = jsonLoans["name"] as! String
                    let location = jsonLoans["location"] as! [String: AnyObject]
                    loan.country = location["country"] as! String
                    loan.use = jsonLoans["use"] as! String
                    loan.amount = jsonLoans["loan_amount"] as! Int
                    items.append(loan)
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({ 
                        self.tableView.reloadData()
                    })
                }
                    } catch{ print("Failed")}
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.name.text = items[indexPath.row].name
        cell.country.text = items[indexPath.row].country
        cell.use.text = items[indexPath.row].use
        cell.amount.text = "$\(items[indexPath.row].amount)"
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
