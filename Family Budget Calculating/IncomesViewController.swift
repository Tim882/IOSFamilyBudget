//
//  IncomesViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 22.09.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

var incomeArray: [NSManagedObject] = [NSManagedObject]()

class IncomesViewController: UIViewController {
    
    var addIncomeButton = UIButton()
    var identyfire = "Mycell"
    var myIncomesTable = UITableView()
    var realoadTableButton = UIButton()
    //var incomeElement: ArrayClass = ArrayClass()
    
    //MARK: - right button
    @objc func performAdd(param: UIBarButtonItem) {
        let addIncome = AddIncomeViewController()
        self.navigationController?.pushViewController(addIncome, animated: true)
    }
    
    //MARK: - reloadTable button
    @objc func reloadTable(param: UIBarButtonItem) {
        refreshTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "Доходы"
        
        //push VC button initialize
        addIncomeButton.setTitle("+", for: .normal)
        addIncomeButton.sizeToFit()
        addIncomeButton.setTitleColor(.black, for: .normal)
        
        //reload table button initialize
        realoadTableButton.setTitle("-", for: .normal)
        realoadTableButton.sizeToFit()
        realoadTableButton.setTitleColor(.black, for: .normal)
        
        // Do any additional setup after loading the view.
        //self.addSubview()
        self.view.backgroundColor = UIColor.white
        addIncomeButton.addTarget(self, action: #selector(performAdd(param:)), for: .touchDown)
        realoadTableButton.addTarget(self, action: #selector(reloadTable(param:)), for: .touchDown)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addIncomeButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: realoadTableButton)
        
        fetchData()
        createTable()
    }
    
    //MARK: - refreshTable
    func refreshTable() {
        myIncomesTable.isEditing = !myIncomesTable.isEditing
    }
    
    //MARK: - createTable
    func createTable() {
        self.myIncomesTable = UITableView(frame: view.bounds, style: .grouped)
        myIncomesTable.register(UITableViewCell.self, forCellReuseIdentifier: identyfire)
        
        self.myIncomesTable.delegate = self
        self.myIncomesTable.dataSource = self
        
        myIncomesTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myIncomesTable)
    }
    
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Incomes")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            incomeArray = result as! [NSManagedObject]
            
        } catch {
            
            print("Failed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension IncomesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.backgroundColor = UIColor.black
    }
    //MARK: - height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height/7
    }
}

extension IncomesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = incomeArray.count
        return numOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfire, for: indexPath)
        let cellHeight = cell.bounds.height/5
        let cellWidth = cell.bounds.width
        
        let cellDateLabel = UILabel()
        let cellSumLabel = UILabel()
        let cellCommentLabel = UILabel()
        let cellCategoryLabel = UILabel()
        let income = incomeArray[indexPath.row]
        
        //date
        cellDateLabel.backgroundColor = .white
        cellDateLabel.textColor = UIColor.black
        cellDateLabel.text = "Дата: \(income.value(forKey: "date") as? String ?? "")"
        
        //comment
        cellCommentLabel.backgroundColor = .white
        cellCommentLabel.textColor = UIColor.black
        cellCommentLabel.numberOfLines = 0
        cellCommentLabel.adjustsFontSizeToFitWidth = true
        
        //cellCommentLabel.sizeToFit()
        cellCommentLabel.text = "Комментарий: \(income.value(forKey: "comment") as? String ?? "")"
        
        //sum
        cellSumLabel.backgroundColor = .white
        cellSumLabel.textColor = UIColor.black
        cellSumLabel.text = "Сумма: \(income.value(forKey: "sum") as? String ?? "")"
        
        //category
        cellCategoryLabel.backgroundColor = .white
        cellCategoryLabel.textColor = UIColor.black
        cellCategoryLabel.text = "Категория: \(income.value(forKey: "category") as? String ?? "")"
        
        
        cellDateLabel.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
        cellCategoryLabel.frame = CGRect(x: 0, y: cellHeight, width: cellWidth, height: cellHeight)
        cellSumLabel.frame = CGRect(x: 0, y: 2*cellHeight, width: cellWidth, height: cellHeight)
        cellCommentLabel.frame = CGRect(x: 0, y: 3*cellHeight, width: cellWidth, height: cellHeight*2)
        cell.contentView.addSubview(cellDateLabel)
        cell.contentView.addSubview(cellCategoryLabel)
        cell.contentView.addSubview(cellSumLabel)
        cell.contentView.addSubview(cellCommentLabel)
        cell.textLabel?.text = ""
        cell.accessoryType = .none
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(incomeArray[indexPath.row])
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
            incomeArray.remove(at: indexPath.row)
            myIncomesTable.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myIncomesTable.reloadData()
    }
}



