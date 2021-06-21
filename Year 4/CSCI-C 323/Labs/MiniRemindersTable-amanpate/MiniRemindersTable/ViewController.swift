//
//  ViewController.swift
//  MiniRemindersTable
//
//  Created by Patel, Aman N on 3/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myContent: UITextField!
    @IBOutlet weak var myCategory: UITextField!
    @IBOutlet weak var myDueDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.myCategory.text = ""
        self.myContent.text = ""
        
    }
    
    @IBAction func addReminder(_ sender: Any) {
        
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let lDataModel = lAppDelegate.myRemindersData
        
        lDataModel.addEvent(content: self.myContent.text ?? "Smile", category: self.myCategory.text ?? "Mood", dueDate: self.myDueDatePicker.date, done: false)
        
        self.myCategory.text = ""
        self.myContent.text = ""
        self.myDueDatePicker.date = Date(timeIntervalSinceNow: TimeInterval(0))
        
    }
    
}

