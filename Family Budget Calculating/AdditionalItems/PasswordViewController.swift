//
//  PasswordViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

class PasswordViewController: UIViewController {

    var sumTextView = UITextView()
    var sumLabel = UILabel()
    var addToDepositSwitch = UISwitch()
    var countButton = UIButton()
    var addDepositCommentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Пароль"
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
        sumLabel.text = "Введите пароль: "
        sumLabel.layer.borderColor = UIColor.gray.cgColor
        sumLabel.layer.borderWidth = 0.5
        self.view.addSubview(sumLabel)
        
        //switch
        addToDepositSwitch.frame = CGRect(origin: CGPoint(x: screenWidth/6*5, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen+5), size: CGSize(width: screenWidth/6, height: helpScreen/6))
        self.view.addSubview(addToDepositSwitch)
        
        //count button
        countButton.setTitle("Сохранить", for: .normal)
        countButton.setTitleColor(.black, for: .normal)
        countButton.layer.borderColor = UIColor.gray.cgColor
        countButton.layer.borderWidth = 0.5
        countButton.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6*7, width: screenWidth, height: helpScreen/3)
        countButton.addTarget(self, action: #selector(count(sender:)), for: .touchDown)
        self.view.addSubview(countButton)
        
        //add switch label
        addDepositCommentLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen, width: screenWidth/6*4.8, height: helpScreen/6)
        addDepositCommentLabel.backgroundColor = .white
        addDepositCommentLabel.textColor = UIColor.black
        addDepositCommentLabel.text = "Использовать пароль: "
        addDepositCommentLabel.layer.borderColor = UIColor.gray.cgColor
        addDepositCommentLabel.layer.borderWidth = 0.5
        self.view.addSubview(addDepositCommentLabel)
    }
    
    @objc func count(sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Password", in: context)
        var newElement = NSManagedObject(entity: entity!, insertInto: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")
        
        var isEmpty: Bool {
            do {
                let count = try context.count(for: request)
                return count == 0 ? true : false
            }
            catch {
                return true
            }
        }

        
        if addToDepositSwitch.isOn {
            
                newElement.setValue(sumTextView.text, forKey: "password")
                newElement.setValue(true, forKey: "use")
                
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
                
                arr.append(newElement)
        }
        else {
            if !isEmpty {
                for i in arr {
                    context.delete(i)
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                    }
                }
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
