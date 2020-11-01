//
//  DepResultViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit

class DepResultViewController: UIViewController {

    var sumLabel = UILabel()
    var termLabel = UILabel()
    var percentLabel = UILabel()
    var addDepositCommentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "Результат"
        
        addElements()
    }

    func addElements() {
        
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //add sum label
        sumLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9, width: screenWidth, height: helpScreen/6)
        sumLabel.backgroundColor = .white
        sumLabel.textColor = UIColor.black
        sumLabel.text = "Сумма вклада: \(depResultArray[0])"
        sumLabel.layer.borderColor = UIColor.gray.cgColor
        sumLabel.layer.borderWidth = 0.5
        self.view.addSubview(sumLabel)
        
        //add final sum label
        termLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6, width: screenWidth, height: helpScreen/6)
        termLabel.backgroundColor = .white
        termLabel.textColor = UIColor.black
        termLabel.text = "Итоговая сумма: \(depResultArray[1])"
        termLabel.layer.borderColor = UIColor.gray.cgColor
        termLabel.layer.borderWidth = 0.5
        self.view.addSubview(termLabel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
