//
//  AccountsViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 04.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

var accountArray: [NSManagedObject] = [NSManagedObject]()

class AccountsViewController: UIViewController {
    
    var addAccountButton = UIButton()
    var realoadTableButton = UIButton()
    var identyfire = "Mycell"
    var myAccountsTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Банковские счета"
        self.view.backgroundColor = UIColor.white
        
        //push VC button initialize
        addAccountButton.setTitle("+", for: .normal)
        addAccountButton.sizeToFit()
        addAccountButton.setTitleColor(.black, for: .normal)
        
        //reload table button initialize
        realoadTableButton.setTitle("-", for: .normal)
        realoadTableButton.sizeToFit()
        realoadTableButton.setTitleColor(.black, for: .normal)
        
        //targets for bar button
        addAccountButton.addTarget(self, action: #selector(performAdd(param:)), for: .touchDown)
        realoadTableButton.addTarget(self, action: #selector(reloadTable(param:)), for: .touchDown)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addAccountButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: realoadTableButton)
        
        fetchData()
        createTable()
    }
    
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Accounts")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            accountArray = result as! [NSManagedObject]
            
        } catch {
            
            print("Failed")
        }
    }
    
    //MARK: - right button
    @objc func performAdd(param: UIBarButtonItem) {
        let addAccount = AddAccountViewController()
        self.navigationController?.pushViewController(addAccount, animated: true)
        //refreshTable()
    }
    
    //MARK: - reloadTable button
    @objc func reloadTable(param: UIBarButtonItem) {
        refreshTable()
    }
    
    func refreshTable() {
        myAccountsTable.isEditing = !myAccountsTable.isEditing
    }
    
    func createTable() {
        self.myAccountsTable = UITableView(frame: view.bounds, style: .grouped)
        myAccountsTable.register(UITableViewCell.self, forCellReuseIdentifier: identyfire)
        
        self.myAccountsTable.delegate = self
        self.myAccountsTable.dataSource = self
        
        myAccountsTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myAccountsTable)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension AccountsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.backgroundColor = UIColor.black
    }
    //MARK: - height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height/7
    }
}

extension AccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = accountArray.count
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
        let account = accountArray[indexPath.row]
        
        //date
        cellDateLabel.backgroundColor = .white
        cellDateLabel.textColor = UIColor.black
        cellDateLabel.text = "Дата: \(account.value(forKey: "date") as? String ?? "")"
        
        //comment
        cellCommentLabel.backgroundColor = .white
        cellCommentLabel.textColor = UIColor.black
        cellCommentLabel.numberOfLines = 0
        cellCommentLabel.adjustsFontSizeToFitWidth = true
        cellCommentLabel.text = "Комментарии: \(account.value(forKey: "comment") as? String ?? "")"
        
        //sum
        cellSumLabel.backgroundColor = .white
        cellSumLabel.textColor = UIColor.black
        cellSumLabel.text = "Сумма: \(account.value(forKey: "sum") as? String ?? "")"
        
        //category
        cellCategoryLabel.backgroundColor = .white
        cellCategoryLabel.textColor = UIColor.black
        cellCategoryLabel.text = "Процент(годовых): \(account.value(forKey: "category") as? String ?? "")"
        
        
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
            
            context.delete(accountArray[indexPath.row])
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
            accountArray.remove(at: indexPath.row)
            myAccountsTable.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myAccountsTable.reloadData()
    }
}

