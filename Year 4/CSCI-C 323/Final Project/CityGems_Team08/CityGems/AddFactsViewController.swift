//
//  Names: Taral Shah, Aman Patel, Vijay Tewari
//  Emails: tarshah@iu.edu, amanpate@iu.edu, vtewari@iu.edu
//  App Name: CityGems
//  Submission Date: May 4, 2021

//  AddFactsViewController.swift
//  CityGems
//
//  Created by Taral Shah on 4/22/21.
//

import UIKit

class AddFactsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var newFact: UITextField!
    
    @IBOutlet weak var citiesPicker: UIPickerView!
    
    // the reference to our AppDelegate:
    var appDelegate: AppDelegate?
    
    //the reference to our data model:
    var myCityGemsModel: CityGemsModel?
    
    var cityData : [Location] = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myCityGemsModel = self.appDelegate?.myCityGemsModel
        
        self.citiesPicker.delegate = self
        self.citiesPicker.dataSource = self
        
        // Do any additional setup after loading the view.
        
        //force unwraps the data for the names of the cities
        cityData = Array(myCityGemsModel!.getLocations())
    }
    
    //this function is triggered by hitting the "confirm" button in the add facts view
    @IBAction func confirmFact(_ sender: Any) {
        //gets information from the UITextLabel and the city picked in the UIPicker
        //stores that information into the database of facts
        
        if let userFact = newFact.text {
            let cityIndex = citiesPicker.selectedRow(inComponent: 0)
            myCityGemsModel?.addAndStoreFact(location: cityData[cityIndex], fact_description: userFact)
        }
        
        //creates a confirmation alert after a user has added a fact
        let alertController = UIAlertController(title: "Fact Added!", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityData[row].theCity + ", " + cityData[row].theState
    }
    
    // makes the keyboard go away when the user clicks the return key after typing into the given UITextField
    // source: Programming iOS 14 by Matt Neuburg
    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        tf.resignFirstResponder()
        return false
    }
}

