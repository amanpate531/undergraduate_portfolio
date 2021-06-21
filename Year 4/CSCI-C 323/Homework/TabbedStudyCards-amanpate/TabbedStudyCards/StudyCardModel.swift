//
//  StudyCardModel.swift
//  TabbedStudyCards
//
//  Created by Patel, Aman N on 2/22/21.
//

import Foundation

class StudyCardModel {
    // instance variables, initialized right here:
    var currentQuestionIndex = -1
    var questions = ["How much is 7+7?",
                     "In what country is Timbuktu?",
                     "What rotates when you ride a bike?",
                     "What color is the sky?",
                     "What is the capital of Canada?",
                     "What is the name of the 14th President?",
                     "How many 2x2 blocks can fit in a 16x16 area?",
                     "What is the smallest country in the world?"]
    var answers = ["14", "Mali", "Wheels", "Blue", "Ottawa", "Franklin Pierce", "64", "Vatican City"]
    
    init () {
        
    }
    
    func getCurrentQuestion() -> String {
        if self.currentQuestionIndex < 0 {
            return self.questions[0]
        }
        return self.questions[self.currentQuestionIndex]
    }
    
    func getCurrentAnswer() -> String {
        if self.currentQuestionIndex < 0 {
            return self.answers[0]
        }
        return self.answers[self.currentQuestionIndex]
    }
    
    func setCurrentQuestion(pString: String) {
        if self.currentQuestionIndex < 0 {
            self.questions[0] = pString
        }
        else {
            self.questions[self.currentQuestionIndex] = pString
        }
    }
    
    func setCurrentAnswer(pString: String) {
        if self.currentQuestionIndex < 0 {
            self.answers[0] = pString
        }
        else {
            self.answers[self.currentQuestionIndex] = pString
        }
    }
    
    func getNextQuestion() -> String {
        self.currentQuestionIndex = self.currentQuestionIndex + 1
        
        if self.currentQuestionIndex >= self.questions.count {
            self.currentQuestionIndex = -1
            return "You have run out of questions, let's restart."
        }
        return self.questions[self.currentQuestionIndex]
    }
    
    func getAnswer() -> String {
        if self.currentQuestionIndex == -1 {
            return ""
        }
        return self.answers[self.currentQuestionIndex]
    }
}
