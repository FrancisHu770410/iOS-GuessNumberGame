//
//  GuessNumberAI.swift
//  GuessNumber
//
//  Created by 胡珀菖 on 2016/6/25.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

import UIKit

class GuessNumberAI: NSObject {
    
    static let sharedAI = GuessNumberAI()
    
    private var answerSet: Set<String> = []
    
    override init() {
        super.init()
        self.createDefualtAnswerSet()
    }
    
    private func createDefualtAnswerSet() {
        self.answerSet = []
        for countIdx in 123...9876 {
            let thousand = floor(Double(countIdx / 1000))
            let hundred = floor(Double((countIdx % 1000) / 100))
            let ten = floor(Double((countIdx % 100) / 10))
            let one = Double(countIdx % 10)
            
            if thousand != hundred && thousand != ten && thousand != one {
                if hundred != ten && hundred != one {
                    if ten != one {
                        let answerString = String.init(format: "%.f%.f%.f%.f", thousand, hundred, ten, one)
                        answerSet.insert(answerString)
                    }
                }
            }
        }
    }
    
    func guessResponse(guessData: (number: String, result: String)) {
        let guessModel = GuessNumberModel()
        guessModel.correctAnswer = guessData.number
        let tempArray = Array(self.answerSet)
        for answer in tempArray {
            let checkResult = guessModel.checkAnswerWithString(guessString: answer)
            if checkResult != guessData.result {
                self.answerSet.remove(answer)
            }
        }
    }
    
    func guessAnswer() -> String {
        let randomIdx = arc4random() % UInt32(self.answerSet.count)
        let guessIdx = self.answerSet.startIndex.advancedBy(Int(randomIdx))
        return self.answerSet[guessIdx]
    }
    
    func resetBrain() {
        self.createDefualtAnswerSet()
    }
}
