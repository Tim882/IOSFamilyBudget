//
//  DepositCalculatorViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit

var depResultArray = [String]()

class DepositCalculatorViewController: UIViewController {

    var sumTextView = UITextView()
    var termTextView = UITextView()
    var percentTextView = UITextView()
    var sumLabel = UILabel()
    var termLabel = UILabel()
    var percentLabel = UILabel()
    var addDepositCommentLabel = UILabel()
    var addToDepositSwitch = UISwitch()
    var countButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Калькулятор вкладов"
        self.view.backgroundColor = UIColor.white
        
        addElements()
    }

    func addElements() {
        
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //add text sum view
        sumTextView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)! * 1.9+helpScreen/6, width: screenWidth, height: helpScreen/6)
        sumTextView.layer.borderWidth = 0.5
        sumTextView.layer.borderColor = UIColor.brown.cgColor
        sumTextView.text = ""
        self.view.addSubview(sumTextView)
        
        //add sum label
        sumLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9, width: screenWidth, height: helpScreen/6)
        sumLabel.backgroundColor = .white
        sumLabel.textColor = UIColor.black
        sumLabel.text = "Сумма: "
        sumLabel.layer.borderColor = UIColor.gray.cgColor
        sumLabel.layer.borderWidth = 0.5
        self.view.addSubview(sumLabel)
        
        //add text term view
        termTextView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)! * 1.9+helpScreen/2, width: screenWidth, height: helpScreen/6)
        termTextView.layer.borderWidth = 0.5
        termTextView.layer.borderColor = UIColor.brown.cgColor
        termTextView.text = ""
        self.view.addSubview(termTextView)
        
        //add term label
        termLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/3, width: screenWidth, height: helpScreen/6)
        termLabel.backgroundColor = .white
        termLabel.textColor = UIColor.black
        termLabel.text = "Срок(лет): "
        termLabel.layer.borderColor = UIColor.gray.cgColor
        termLabel.layer.borderWidth = 0.5
        self.view.addSubview(termLabel)
        
        //add text percent view
        percentTextView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)! * 1.9+helpScreen/6*5, width: screenWidth, height: helpScreen/6)
        percentTextView.layer.borderWidth = 0.5
        percentTextView.layer.borderColor = UIColor.brown.cgColor
        percentTextView.text = ""
        self.view.addSubview(percentTextView)
        
        //add percent label
        percentLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/3*2, width: screenWidth, height: helpScreen/6)
        percentLabel.backgroundColor = .white
        percentLabel.textColor = UIColor.black
        percentLabel.text = "Процент(годовых): "
        percentLabel.layer.borderColor = UIColor.gray.cgColor
        percentLabel.layer.borderWidth = 0.5
        self.view.addSubview(percentLabel)
        
        //add switch label
        addDepositCommentLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen, width: screenWidth/6*4.8, height: helpScreen/6)
        addDepositCommentLabel.backgroundColor = .white
        addDepositCommentLabel.textColor = UIColor.black
        addDepositCommentLabel.text = "Добавлять начисленные проценты: "
        addDepositCommentLabel.layer.borderColor = UIColor.gray.cgColor
        addDepositCommentLabel.layer.borderWidth = 0.5
        self.view.addSubview(addDepositCommentLabel)

        //switch
        addToDepositSwitch.frame = CGRect(origin: CGPoint(x: screenWidth/6*5, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen+5), size: CGSize(width: screenWidth/6, height: helpScreen/6))
        self.view.addSubview(addToDepositSwitch)
        
        //count button
        countButton.setTitle("Посчитать", for: .normal)
        countButton.setTitleColor(.black, for: .normal)
        countButton.layer.borderColor = UIColor.gray.cgColor
        countButton.layer.borderWidth = 0.5
        countButton.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6*7, width: screenWidth, height: helpScreen/3)
        countButton.addTarget(self, action: #selector(count(sender:)), for: .touchDown)
        self.view.addSubview(countButton)
    }
    
    @objc func count(sender: UIButton) {
        if (addToDepositSwitch.isOn) {
            
            var sum: Double
            let term: Int
            var percent: Double
            
            
            if Double(sumTextView.text) != nil && Double(sumTextView.text) != nil && Double(sumTextView.text) != nil {
                
                sum = Double(sumTextView.text)!
                term = Int(termTextView.text)!
                let sumBegin = sum
                percent = Double(percentTextView.text)!
                
                for _ in 1...term {
                    sum+=(sum*percent/100)
                }
                depResultArray = [String]()
                depResultArray.append(String(sumBegin))
                depResultArray.append(String(sum))
                let depResVC = DepResultViewController()
                self.navigationController?.pushViewController(depResVC, animated: true)
            }
            else {
                let alertController = UIAlertController(title: "Ошибка", message: "Неправильно введены данные", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ясно", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else {
            
            var sum: Double
            let term: Int
            var percent: Double
            
            if Double(sumTextView.text) != nil && Double(sumTextView.text) != nil && Double(sumTextView.text) != nil {
                sum = Double(sumTextView.text)!
                let sumBegin = sum
                term = Int(termTextView.text)!
                percent = Double(percentTextView.text)!
                for _ in 1...term {
                    sum+=(sum*percent/100)
                }
                depResultArray = [String]()
                depResultArray.append(String(sumBegin))
                depResultArray.append(String(sum-sumBegin))
                let depResVC = DepResultViewController()
                self.navigationController?.pushViewController(depResVC, animated: true)
            }
            else {
                let alertController = UIAlertController(title: "Ошибка", message: "Неправильно введены данные", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ясно", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
