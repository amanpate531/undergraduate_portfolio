//
//  ViewController.swift
//  StudyCards
//
//  Created by Patel, Aman N on 1/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    @IBAction func showQuestion(_ sender: Any){
        self.questionLabel.text = "How old are you?"
        self.answerLabel.text = "(... try guessing...)"
    }
    @IBAction func showAnswer(_ sender: Any){
        if self.questionLabel.text != "" {
            self.answerLabel.text = "I'm almost 6 years old! (thst was the Swift programming language's answer)"
        }
    }
    
}

