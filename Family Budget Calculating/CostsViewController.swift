//
//  CostsViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 22.09.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

var costArray: [NSManagedObject] = [NSManagedObject]()

class CostsViewController: UIViewController {
    
    var addCostButton = UIButton()
    var myCostsTable = UITableView()
    var identyfire = "Mycell"
    var numberOfDayCost = 3
    var realoadTableButton = UIButton()
    
    //MARK: - rightbutton
    @objc func performAdd(param: UIBarButtonItem) {
        let addCost = AddCostViewController()
        self.navigationController?.pushViewController(addCost, animated: true)
    }
    
    //MARK: - reloadTable button
    @objc func reloadTable(param: UIBarButtonItem) {
        myCostsTable.isEditing = !myCostsTable.isEditing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Расходы"
        
        //push VC button initialize
        addCostButton.setTitle("+", for: .normal)
        addCostButton.sizeToFit()
        addCostButton.setTitleColor(.black, for: .normal)
        
        //reload table button initialize
        realoadTableButton.setTitle("-", for: .normal)
        realoadTableButton.sizeToFit()
        realoadTableButton.setTitleColor(.black, for: .normal)
        
        self.view.backgroundColor = UIColor.white
        self.tabBarItem.title = "Costs"
        
        addCostButton.addTarget(self, action: #selector(performAdd(param:)), for: .touchDown)
        realoadTableButton.addTarget(self, action: #selector(reloadTable(param:)), for: .touchDown)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addCostButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: realoadTableButton)
        
        fetchData()
        createTable()
        
    }
    
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Costs")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            costArray = result as! [NSManagedObject]
            
        } catch {
            print("Failed")
        }
    }
    
    //MARK: - create table
    func createTable() {
        self.myCostsTable = UITableView(frame: view.bounds, style: .grouped)
        myCostsTable.register(UITableViewCell.self, forCellReuseIdentifier: identyfire)
        
        self.myCostsTable.delegate = self
        self.myCostsTable.dataSource = self
        
        myCostsTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myCostsTable)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension CostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //indexPat.backgroudColor = UIColor.red
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.backgroundColor = UIColor.black
    }
    //MARK: - height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height/7
    }
}

extension CostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = costArray.count
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
        let cost = costArray[indexPath.row]
        
        //date
        cellDateLabel.backgroundColor = .white
        cellDateLabel.textColor = UIColor.black
        cellDateLabel.text = "Дата: \(cost.value(forKey: "date") as? String ?? "")"
        
        //comment
        cellCommentLabel.backgroundColor = .white
        cellCommentLabel.textColor = UIColor.black
        cellCommentLabel.numberOfLines = 0
        cellCommentLabel.adjustsFontSizeToFitWidth = true
        cellCommentLabel.text = "Комментарий: \(cost.value(forKey: "comment") as? String ?? "")"
        
        //sum
        cellSumLabel.backgroundColor = .white
        cellSumLabel.textColor = UIColor.black
        cellSumLabel.text = "Сумма: \(cost.value(forKey: "sum") as? String ?? "")"
        
        //category
        cellCategoryLabel.backgroundColor = .white
        cellCategoryLabel.textColor = UIColor.black
        cellCategoryLabel.text = "Категория: \(cost.value(forKey: "category") as? String ?? "")"
        
        
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
            
            context.delete(costArray[indexPath.row])
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
            costArray.remove(at: indexPath.row)
            myCostsTable.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myCostsTable.reloadData()
    }
}


