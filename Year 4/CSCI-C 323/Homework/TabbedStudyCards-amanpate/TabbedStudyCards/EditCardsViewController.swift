//
//  EditCardsViewController.swift
//  TabbedStudyCards
//
//  Created by Patel, Aman N on 2/22/21.
//

import UIKit

class EditCardsViewController: UIViewController {

    var appDelegate: AppDelegate?
    var myStudyCardModel: StudyCardModel?
    
    @IBOutlet weak var questionTextField: UITextField!
        
        @IBOutlet weak var answerTextField: UITextField!
        
        @IBAction func buttonOKAction(sender: AnyObject) {
            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            self.myStudyCardModel = self.appDelegate?.myStudyCardModel
            
            self.myStudyCardModel!.setCurrentQuestion(pString: self.questionTextField.text!)
            self.myStudyCardModel!.setCurrentAnswer(pString: self.answerTextField.text!)
            self.questionTextField.text = "You have edited a question."
            self.answerTextField.text = "Questions cannot be edited anymore"
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view, typically from a nib.
            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            self.myStudyCardModel = self.appDelegate?.myStudyCardModel
            
            let current_answer: String = self.myStudyCardModel!.getCurrentAnswer()
            let current_question: String = self.myStudyCardModel!.getCurrentQuestion()
            self.questionTextField.text = current_question
            self.answerTextField.text = current_answer
        }
    
}
