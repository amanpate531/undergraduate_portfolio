//
//  MiniRemindersDataModel.swift
//  SplitMiniReminders
//
//  Created by Patel, Aman N on 3/15/21.
//

import Foundation

class MiniRemindersDataModel {
    
    var myData : [Item] = []
    
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
    
    }
    
    func numReminders() -> Int {
        return self.myData.count
    }
    
}

class Item {
    
    var theContent: String
    var theCategory: String
    var theDate: Date
    var theDoneFlag: Bool
    
    init(pContent: String,
         pCategory: String,
         pDueDate: Date,
         pDone: Bool) {
        
        self.theContent = pContent
        self.theCategory = pCategory
        self.theDate = pDueDate
        self.theDoneFlag = pDone
        
    }
    
}
