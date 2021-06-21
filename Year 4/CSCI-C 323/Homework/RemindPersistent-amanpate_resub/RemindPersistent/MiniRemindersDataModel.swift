//
//  MiniRemindersDataModel.swift
//  SplitMiniReminders
//
//  Created by Patel, Aman N on 3/15/21.
//

import Foundation

class MiniRemindersDataModel {
    
    var myData: [Item] = []
    
    func addEvent(content: String,
                  category: String,
                  dueDate: Date,
                  done: Bool) {
        
        self.myData.append(
        
            Item(pContent: content,
                 pCategory: category,
                 pDueDate: dueDate,
                 pDone: done)
        
        )
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let encoded = try PropertyListEncoder().encode(myData)
            let myFile = docsurl.appendingPathComponent("items.plist")
            try encoded.write(to: myFile, options: .atomic)
        } catch {
            print(error)
        }
        
        
    
    }
    
    func numReminders() -> Int {
        return self.myData.count
    }
    
}

class Item: NSObject, Codable {
    
    var theContent: String
    var theCategory: String
    var theDate: Date
    var theDoneFlag: Bool
    
    override var description: String {
        return "Content: " + self.theContent + ", Category: " + self.theCategory
    }
    
    init(pContent: String,
         pCategory: String,
         pDueDate: Date,
         pDone: Bool) {
        
        self.theContent = pContent
        self.theCategory = pCategory
        self.theDate = pDueDate
        self.theDoneFlag = pDone
        super.init()
        
    }
    
}
