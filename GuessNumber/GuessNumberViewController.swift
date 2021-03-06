//
//  GuessNumberViewController.swift
//  GuessNumber
//
//  Created by 胡珀菖 on 2016/6/24.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

import UIKit

class GuessNumberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var guessNumberView: GuessNumberView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessNumberView = GuessNumberView(frame: self.view.frame)
        self.view = self.guessNumberView
        
        self.guessNumberView?.guessHistoryTableView?.delegate = self
        self.guessNumberView?.guessHistoryTableView?.dataSource = self
        self.guessNumberView?.guessField?.delegate = self
        self.guessNumberView?.guessBtn?.addTarget(self, action: #selector(self.enterAction), forControlEvents: .TouchUpInside)
        self.guessNumberView?.switchButton?.addTarget(self, action: #selector(self.switchAiAction), forControlEvents: .ValueChanged)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GuessNumberModel.sharedInstance.guessArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("GuessNumberCellIdentifier")
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "GuessNumberCellIdentifier")
        }
        let guessData = GuessNumberModel.sharedInstance.guessArray![indexPath.row]
        cell?.textLabel?.text = guessData.guessNumber + "  Result: " + guessData.guessResult
        return cell!
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty {
            if textField.text?.characters.count == 4 {
                return false
            } else if textField.text?.containsString(string) == true {
                return false
            }
        }
        return true
    }
    
    func aiGuessAction() {
        
        var guessResult = ""
        
        while guessResult != "4A0B" {
            var newGuessData: (guessNumber: String, guessResult: String) = ("", "")
            newGuessData.guessNumber = GuessNumberAI.sharedAI.guessAnswer()
            newGuessData.guessResult = GuessNumberModel.sharedInstance.checkAnswerWithString(guessString: newGuessData.guessNumber)
            GuessNumberModel.sharedInstance.guessArray?.append(newGuessData)
            GuessNumberAI.sharedAI.guessResponse((newGuessData.guessNumber, newGuessData.guessResult))
            guessResult = newGuessData.guessResult

        }
        let message = "AI猜了" + "\((GuessNumberModel.sharedInstance.guessArray?.count)!)" + "次猜中"
        let alertController = UIAlertController.init(title: "訊息", message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction.init(title: "確定", style: .Default, handler: { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(alertAction)
        self.guessNumberView?.guessField?.text = ""
        self.guessNumberView?.guessField?.resignFirstResponder()
        self.guessNumberView?.guessHistoryTableView?.reloadData()
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    func enterAction() {
        if self.guessNumberView?.guessField?.text?.characters.count == 4 {
            if self.guessNumberView?.switchButton?.on == true {
                GuessNumberModel.sharedInstance.resetData()
                GuessNumberModel.sharedInstance.correctAnswer = self.guessNumberView?.guessField?.text
                GuessNumberAI.sharedAI.resetBrain()
                self.aiGuessAction()
            } else {
                var newGuessData: (guessNumber: String, guessResult: String) = ("", "")
                newGuessData.guessNumber = (self.guessNumberView?.guessField?.text)!
                newGuessData.guessResult = GuessNumberModel.sharedInstance.checkAnswerWithString(guessString: (self.guessNumberView?.guessField?.text)!)
                GuessNumberModel.sharedInstance.guessArray?.append(newGuessData)
                self.guessNumberView?.guessHistoryTableView?.reloadData()
                self.guessNumberView?.guessField?.text = ""
                self.guessNumberView?.guessField?.resignFirstResponder()
                if newGuessData.guessResult == "4A0B" {
                    let alertController = UIAlertController.init(title: "訊息", message: "已猜中", preferredStyle: .Alert)
                    let alertAction = UIAlertAction.init(title: "確定", style: .Default, handler: { (action) in
                        GuessNumberModel.sharedInstance.resetData()
                        self.guessNumberView?.guessHistoryTableView?.reloadData()
                        alertController.dismissViewControllerAnimated(true, completion: nil)
                    })
                    alertController.addAction(alertAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }

            }
        } else {
            
        }
        
    }
    
    func switchAiAction() {
        self.guessNumberView?.guessField?.text = ""
        self.guessNumberView?.guessField?.resignFirstResponder()
        GuessNumberModel.sharedInstance.resetData()
        GuessNumberAI.sharedAI.resetBrain()
        self.guessNumberView?.guessHistoryTableView?.reloadData()
        if self.guessNumberView?.switchButton?.on == true {
            self.guessNumberView?.guessField?.placeholder = "請輸入要AI猜的數字"
        } else {
            self.guessNumberView?.guessField?.placeholder = "猜四位數字"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
