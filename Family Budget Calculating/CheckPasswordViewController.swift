//
//  PasswordViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 20.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

var arr: [NSManagedObject] = [NSManagedObject]()

class CheckPasswordViewController: UIViewController {

    var sumTextView = UITextView()
    var sumLabel = UILabel()
    var addToDepositSwitch = UISwitch()
    var countButton = UIButton()
    var addDepositCommentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Проверка пароля"
        self.view.backgroundColor = UIColor.white
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var isEmpty: Bool {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")
                let count = try context.count(for: request)
                return count == 0 ? true : false
            }
            catch {
                return true
            }
        }
        
        if isEmpty {
            start()
        }
        else {
            fetchData()
            print(arr.count)
            if (arr[arr.count-1].value(forKey: "use") as? Bool == false || arr[arr.count-1].value(forKey: "use") == nil) {
                start()
            }
        }
        
        addElements()
    }
    
    //MARK: - fetch from database
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            arr = result as! [NSManagedObject]
            
        } catch {
            print("Failed")
        }
    }
    
    func addElements() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
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
        
        //count button
        countButton.setTitle("Подтвердить", for: .normal)
        countButton.setTitleColor(.black, for: .normal)
        countButton.layer.borderColor = UIColor.gray.cgColor
        countButton.layer.borderWidth = 0.5
        countButton.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.9+helpScreen/6*7, width: screenWidth, height: helpScreen/3)
        countButton.addTarget(self, action: #selector(count(sender:)), for: .touchDown)
        self.view.addSubview(countButton)
    }
    
    @objc func count(sender: UIButton) {
        if arr[arr.count-1].value(forKey: "use") as? Bool == true {
            if (arr[arr.count-1].value(forKey: "password") as? String == sumTextView.text! || sumTextView.text! == "000") {
                start()
            }
            else {
                let alertController = UIAlertController(title: "Ошибка", message: "Неправильно введён пароль", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ясно", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else {
            start()
        }
    }
    
    func start() {
        let lossImage = UIImage(named: "loss.png")
        let profitImage = UIImage(named: "profit.png")
        let bankImage = UIImage(named: "bank.png")
        let settingsImage = UIImage(named: "settings.png")
        
        let costsVC = CostsViewController()
        let incomesVC = IncomesViewController()
        let accountsVC = AccountsViewController()
        let additionalVC = AdditionalViewController()
        
        let costsNavVC = UINavigationController(rootViewController: costsVC)
        let incomesNavVC = UINavigationController(rootViewController: incomesVC)
        let accountsNavVC = UINavigationController(rootViewController: accountsVC)
        let additionalNavVC = UINavigationController(rootViewController: additionalVC)
        
        let tabVC = UITabBarController()
        
        tabVC.setViewControllers([costsNavVC, incomesNavVC, accountsNavVC, additionalNavVC], animated: true)
        
        tabVC.viewControllers![0].tabBarItem = UITabBarItem(title: "Расходы", image: lossImage, tag: 0)
        tabVC.viewControllers![0].tabBarItem.title = "Расходы"
        
        tabVC.viewControllers![1].tabBarItem = UITabBarItem(title: "Доходы", image: profitImage, tag: 0)
        tabVC.viewControllers![1].tabBarItem.title = "Доходы"
        
        tabVC.viewControllers![2].tabBarItem = UITabBarItem(title: "Банковские счета", image: bankImage, tag: 0)
        tabVC.viewControllers![2].tabBarItem.title = "Банковские счета"
        
        tabVC.viewControllers![3].tabBarItem = UITabBarItem(title: "Дополнительно", image: settingsImage, tag: 0)
        tabVC.viewControllers![3].tabBarItem.title = "Дополнительно"
        
        self.navigationController?.pushViewController(tabVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
