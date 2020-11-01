//
//  StatisticsViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

class StatisticsViewController: UIViewController {

    var date = NSDate()
    var balance: Int = 0
    var commonPerWeek: (Int, Int) = (0, 0)
    var commonPerTwoWeeks: (Int, Int) = (0, 0)
    var commonPerMonth: (Int, Int) = (0, 0)
    var balanceLabel = UILabel()
    var statisticsPerWeekLabel = UILabel()
    var statisticsPerTwoWeeksLabel = UILabel()
    var statisticsPerMonthLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Статистика"
        self.view.backgroundColor = UIColor.white
        
        balance = findBalance()
        commonPerWeek = findStatistics(interval: 604800.0)
        commonPerTwoWeeks = findStatistics(interval: 1209600.0)
        commonPerMonth = findStatistics(interval: 2592000.0)
        createLabels()
    }

    //MARK: - save results to labels
    
    
    //MARK: - find balance
    func  findBalance() -> Int {
        var costs: Int = 0
        var incomes: Int = 0
        
        for i in costArray {
            costs-=Int((i.value(forKey: "sum") as? String)!)!
        }
        for i in incomeArray {
            incomes+=Int((i.value(forKey: "sum") as? String)!)!
        }
        return costs+incomes
    }
    
    //MARK: - find statistics
    func findStatistics(interval: Double) -> (Int, Int) {
        var commonIncome: Int = 0
        var commonCost: Int = 0
        for i in costArray {
            date = dateFromString(dateStr: (i.value(forKey: "date") as? String)!)
            if date.timeIntervalSinceNow < interval {
                commonCost-=Int((i.value(forKey: "sum") as? String)!)!
            }
        }
        for i in incomeArray {
            date = dateFromString(dateStr: (i.value(forKey: "date") as? String)!)
            if date.timeIntervalSinceNow < interval {
                commonIncome+=Int((i.value(forKey: "sum") as? String)!)!
            }
        }
        return (commonCost, commonIncome)
    }
    
    //MARK: - create labels
    func createLabels() {
        
        let height = (self.view.bounds.height-(self.navigationController?.navigationBar.bounds.height)!*2)/4
        
        //balance
        balanceLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!, width: self.view.bounds.width, height: height)
        balanceLabel.backgroundColor = .white
        balanceLabel.textColor = UIColor.black
        balanceLabel.text = "Баланс: \(balance)"
        balanceLabel.numberOfLines = 0
        balanceLabel.lineBreakMode = .byWordWrapping
        balanceLabel.layer.borderColor = UIColor.gray.cgColor
        balanceLabel.layer.borderWidth = 0.5
        self.view.addSubview(balanceLabel)
        
        //statistics per week
        statisticsPerWeekLabel.frame = CGRect(x: 0, y: height+(self.navigationController?.navigationBar.bounds.height)!, width: self.view.bounds.width, height: height)
        statisticsPerWeekLabel.backgroundColor = .white
        statisticsPerWeekLabel.textColor = UIColor.black
        statisticsPerWeekLabel.numberOfLines = 0
        statisticsPerWeekLabel.lineBreakMode = .byWordWrapping
        statisticsPerWeekLabel.text = "Расходы за неделю: \(commonPerWeek.0), доходы за неделю: \(commonPerWeek.1)"
        statisticsPerWeekLabel.layer.borderColor = UIColor.gray.cgColor
        statisticsPerWeekLabel.layer.borderWidth = 0.5
        self.view.addSubview(statisticsPerWeekLabel)
        
        //statistics per two weeks
        statisticsPerTwoWeeksLabel.frame = CGRect(x: 0, y: height*2+(self.navigationController?.navigationBar.bounds.height)!, width: self.view.bounds.width, height: height)
        statisticsPerTwoWeeksLabel.backgroundColor = .white
        statisticsPerTwoWeeksLabel.textColor = UIColor.black
        statisticsPerTwoWeeksLabel.numberOfLines = 0
        statisticsPerTwoWeeksLabel.lineBreakMode = .byWordWrapping
        statisticsPerTwoWeeksLabel.text = "Расходы за 2 недели: \(commonPerTwoWeeks.0), доходы за 2 недели: \(commonPerTwoWeeks.1)"
        statisticsPerTwoWeeksLabel.layer.borderColor = UIColor.gray.cgColor
        statisticsPerTwoWeeksLabel.layer.borderWidth = 0.5
        self.view.addSubview(statisticsPerTwoWeeksLabel)
        
        //statistics per month
        statisticsPerMonthLabel.frame = CGRect(x: 0, y: height*3+(self.navigationController?.navigationBar.bounds.height)!, width: self.view.bounds.width, height: height)
        statisticsPerMonthLabel.backgroundColor = .white
        statisticsPerMonthLabel.numberOfLines = 0
        statisticsPerMonthLabel.textColor = UIColor.black
        statisticsPerMonthLabel.lineBreakMode = .byWordWrapping
        statisticsPerMonthLabel.text = "Расходы за месяц: \(commonPerMonth.0), доходы за месяц: \(commonPerMonth.1)"
        statisticsPerMonthLabel.layer.borderColor = UIColor.gray.cgColor
        statisticsPerMonthLabel.layer.borderWidth = 0.5
        self.view.addSubview(statisticsPerMonthLabel)
    }
    
    func dateFromString (dateStr: String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: dateStr)
        return date! as NSDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
