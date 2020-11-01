//
//  CredResultViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit

class CredResultViewController: UIViewController {

    var sumLabel = UILabel()
    var termLabel = UILabel()
    var percentLabel = UILabel()
    var monthlyPayLabel = UILabel()
    var overpaymentLabel = UILabel()
    
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
        sumLabel.text = "Сумма кредита: \(credResultArray[0])"
        sumLabel.layer.borderColor = UIColor.gray.cgColor
        sumLabel.layer.borderWidth = 0.5
        self.view.addSubview(sumLabel)
        
        //add term label
        termLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6, width: screenWidth, height: helpScreen/6)
        termLabel.backgroundColor = .white
        termLabel.textColor = UIColor.black
        termLabel.text = "Срок(лет): \(credResultArray[1])"
        termLabel.layer.borderColor = UIColor.gray.cgColor
        termLabel.layer.borderWidth = 0.5
        self.view.addSubview(termLabel)
        
        //add percent label
        percentLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6*2, width: screenWidth, height: helpScreen/6)
        percentLabel.backgroundColor = .white
        percentLabel.textColor = UIColor.black
        percentLabel.text = "Процент(годовых): \(credResultArray[2])"
        percentLabel.layer.borderColor = UIColor.gray.cgColor
        percentLabel.layer.borderWidth = 0.5
        self.view.addSubview(percentLabel)
        
        //add monthly payment label
        monthlyPayLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6*3, width: screenWidth, height: helpScreen/6)
        monthlyPayLabel.backgroundColor = .white
        monthlyPayLabel.textColor = UIColor.black
        monthlyPayLabel.text = "Ежемесячный платёж: \(credResultArray[3])"
        monthlyPayLabel.layer.borderColor = UIColor.gray.cgColor
        monthlyPayLabel.layer.borderWidth = 0.5
        self.view.addSubview(monthlyPayLabel)
        
        //add overpayment label
        overpaymentLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6*4, width: screenWidth, height: helpScreen/6)
        overpaymentLabel.backgroundColor = .white
        overpaymentLabel.textColor = UIColor.black
        overpaymentLabel.text = "Итоговые выплаты: \(credResultArray[4])"
        overpaymentLabel.layer.borderColor = UIColor.gray.cgColor
        overpaymentLabel.layer.borderWidth = 0.5
        self.view.addSubview(overpaymentLabel)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
