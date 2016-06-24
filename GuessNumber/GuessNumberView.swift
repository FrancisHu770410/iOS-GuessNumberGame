//
//  GuessNumberView.swift
//  GuessNumber
//
//  Created by 胡珀菖 on 2016/6/24.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

import UIKit

class GuessNumberView: UIView {
    
    var guessHistoryTableView: UITableView?
    
    var guessField: UITextField?
    
    var guessBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.guessHistoryTableView = UITableView.init(frame: CGRectMake(0, 100, self.frame.size.width, CGRectGetHeight(self.frame) - 100))
        self.addSubview(self.guessHistoryTableView!)
        
        self.guessField = UITextField.init(frame: CGRectMake(CGRectGetMidX(self.frame) - 140, 40, 200, 50))
        self.guessField?.keyboardType = .PhonePad
        self.guessField?.textAlignment = .Center
        self.guessField?.placeholder = "輸入四位數字"
        self.guessField?.layer.borderWidth = 1.0
        self.guessField?.layer.cornerRadius = 5.0
        self.addSubview(self.guessField!)
        
        self.guessBtn = UIButton.init(frame: CGRectMake(CGRectGetMaxX(self.guessField!.frame) + 10, CGRectGetMinY(self.guessField!.frame), 75, 50))
        self.guessBtn?.setTitle("Enter", forState: .Normal)
        self.guessBtn?.backgroundColor = UIColor.blackColor()
        self.guessBtn?.alpha = 0.7
        self.guessBtn?.layer.cornerRadius = 5.0
        self.addSubview(self.guessBtn!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
