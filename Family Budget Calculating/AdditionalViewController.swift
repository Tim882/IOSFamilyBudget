//
//  AdditionalViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit

var additionalArray = ["Статистика", "Кредитный калькулятор", "Калькулятор вкладов", "Конвертер", "Пароль"]

class AdditionalViewController: UIViewController {

    var identyfire = "Mycell"
    var myAdditionalTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Дополнительно";
        self.view.backgroundColor = UIColor.white;
        
        createTable()
    }
    
    func createTable() {
        self.myAdditionalTable = UITableView(frame: view.bounds, style: .grouped)
        myAdditionalTable.register(UITableViewCell.self, forCellReuseIdentifier: identyfire)
        
        self.myAdditionalTable.delegate = self
        self.myAdditionalTable.dataSource = self
        
        myAdditionalTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myAdditionalTable)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension AdditionalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.backgroundColor = UIColor.black
    }
    //MARK: - height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height/10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (additionalArray[indexPath.item] == "Статистика") {
            let statistics = StatisticsViewController()
            self.navigationController?.pushViewController(statistics, animated: true)
        }
        else if (additionalArray[indexPath.item] == "Конвертер") {
            let converter = ConverterViewController()
            self.navigationController?.pushViewController(converter, animated: true)
        }
        else if (additionalArray[indexPath.item] == "Кредитный калькулятор") {
            let creditCalculator = CreditCalculatorViewController()
            self.navigationController?.pushViewController(creditCalculator, animated: true)
        }
        else if (additionalArray[indexPath.item] == "Калькулятор вкладов") {
            let depositCalculator = DepositCalculatorViewController()
            self.navigationController?.pushViewController(depositCalculator, animated: true)
        }
        else if (additionalArray[indexPath.item] == "Пароль") {
            let password = PasswordViewController()
            self.navigationController?.pushViewController(password, animated: true)
        }
    }
}

extension AdditionalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = additionalArray.count
        return numOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfire, for: indexPath)
        
        cell.textLabel?.text = additionalArray[indexPath.item]
        cell.accessoryType = .none
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
