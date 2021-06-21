//
//  ViewController.swift
//  StudyCardsWithModel
//
//  Created by Patel, Aman N on 1/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    let myStudyCardModel = StudyCardModel()
    
    @IBAction func showQuestion(_ sender: Any){
        let lQuestion: String = self.myStudyCardModel.getNextQuestion()
        
        self.questionLabel.text = lQuestion
        self.answerLabel.text = ""
    }
    @IBAction func showAnswer(_ sender: Any){
        let lAnswer: String = self.myStudyCardModel.getAnswer()
        
        self.answerLabel.text = lAnswer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

