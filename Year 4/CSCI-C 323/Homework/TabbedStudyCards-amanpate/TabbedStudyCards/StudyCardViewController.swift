//
//  StudyCardViewController.swift
//  StudyCardsWithModel
//
//  Created by Patel, Aman N on 2/22/21.
//

import UIKit

class StudyCardViewController: UIViewController {

    var appDelegate: AppDelegate?
    var myStudyCardModel: StudyCardModel?
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    @IBAction func showQuestion(_ sender: Any){
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.myStudyCardModel = self.appDelegate?.myStudyCardModel
        
        
        let lQuestion: String = self.myStudyCardModel!.getNextQuestion()
        
        self.questionLabel.text = lQuestion
        self.answerLabel.text = ""
    }
    @IBAction func showAnswer(_ sender: Any){
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.myStudyCardModel = self.appDelegate?.myStudyCardModel
        
        let lAnswer: String = self.myStudyCardModel!.getAnswer()
        
        self.answerLabel.text = lAnswer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


