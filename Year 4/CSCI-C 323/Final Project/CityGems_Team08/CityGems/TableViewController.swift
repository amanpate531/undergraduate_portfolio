//
//  Names: Taral Shah, Aman Patel, Vijay Tewari
//  Emails: tarshah@iu.edu, amanpate@iu.edu, vtewari@iu.edu
//  App Name: CityGems
//  Submission Date: May 4, 2021

//  TableViewController.swift
//  CityGems
//
//  Created by Taral Shah on 4/22/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    // the reference to our AppDelegate:
    var appDelegate: AppDelegate?
    
    //the reference to our data model:
    var myCityGemsModel: CityGemsModel?
    
    //all of the facts that have been displayed to the user, which will all be put into the table:
    var tableFactsArray: [(Location, [Fact])]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myCityGemsModel = self.appDelegate?.myCityGemsModel
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    // returns the number of sections in the table, which in our case is the number of unique locations that have been displayed to the user
    override func numberOfSections(in tableView: UITableView) -> Int {
        let tableFacts = myCityGemsModel?.getTableFacts()
        tableFactsArray = myCityGemsModel?.dictionaryToArray(theDictionary: tableFacts!)
        // #warning Incomplete implementation, return the number of sections
        return tableFactsArray!.count
    }
    
    // returns the number of rows for the given section; in our case, the number of rows is the number of facts that have been displayed to the user at the location corresponding to the given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableFactsArray![section].1.count
    }
    
    // returns the cell to be displayed at the given IndexPath; in our case, the content of the returned cell is the fact corresponding to the given IndexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        cell.textLabel?.text = tableFactsArray![indexPath.section].1[indexPath.row].theFactDescription
        return cell
    }
    
    // returns the title of the given section; in our case, the title is the location corresponding to the given section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        let city: String = tableFactsArray![section].0.theCity
        let state: String = tableFactsArray![section].0.theState
        return "\(city), \(state)"
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
