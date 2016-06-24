//
//  GuessNumberModel.swift
//  GuessNumber
//
//  Created by 胡珀菖 on 2016/6/24.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

import UIKit

class GuessNumberModel: NSObject {
    
    static let sharedInstance = GuessNumberModel()
    
    var guessArray: Array<(guessNumber: String, guessResult: String)>?
    
    private var correctAnswer: String?
    
    override init() {
        super.init()
        self.resetData()
    }
    
    private func createAnswer() {
        self.correctAnswer = ""
        var numberSet: Set<String> = []
        while numberSet.count < 4 {
            let numberValue = String.init(format: "%d", arc4random() % 10)
            numberSet.insert(numberValue)
        }
        for str in numberSet {
            self.correctAnswer? += str
        }
    }
    
    func checkAnswerWithString(guessString string: String) -> String {
        let userAnswerArray = Array(string.characters)
        let correctAnswerArray = Array(self.correctAnswer!.characters)
        
        var aCount = 0
        var bCount = 0
        for strIndex in 0 ..< 4 {
            if self.correctAnswer?.containsString(String(userAnswerArray[strIndex])) == true {
                bCount += 1
            }
            if userAnswerArray[strIndex] == correctAnswerArray[strIndex] {
                aCount += 1
            }
        }
        
        bCount -= aCount
        let resultString = "\(aCount)" + "A" + "\(bCount)" + "B"
        return resultString
    }
    
    func resetData() {
        self.guessArray = []
        self.createAnswer()
    }
    
}
