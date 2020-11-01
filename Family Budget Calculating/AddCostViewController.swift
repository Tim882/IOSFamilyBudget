//
//  AddCostViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 23.09.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit
import CoreData

class AddCostViewController: UIViewController {
    
    var digitArray = [UIButton]()
    let saveButton = UIButton()
    let emptyButton = UIButton()
    let okButton = UIButton()
    var sumLabel = UILabel()
    var datePicker = UIDatePicker()
    var categoryPicker = UIPickerView()
    var commentTextField = UITextView()
    var elementAdd: ArrayClass = ArrayClass()
    
    var categoryArray = ["Без названия", "Авто и транспорт", "Продукты питания", "Одежда и обувь", "Кредит", "Квартира", "Кафе и рестораны", "Развлечения", "Путешествия", "Здоровье", "Промтовары", "Гаджеты", "Телефон", "Непредвиденные"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "Добавить расходы"
        
        addDigitElements()
        addButtons()
        addCostElements()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - add income elements
    func addCostElements() {
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //add label
        sumLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.5, width: screenWidth, height: helpScreen/6)
        sumLabel.backgroundColor = .white
        sumLabel.textColor = UIColor.black
        sumLabel.text = ""
        sumLabel.layer.borderColor = UIColor.gray.cgColor
        sumLabel.layer.borderWidth = 0.5
        self.view.addSubview(sumLabel)
        
        //add text view
        commentTextField.frame = CGRect(x: 0, y: helpScreen/3*2 + (self.navigationController?.navigationBar.bounds.height)! * 2.1, width: screenWidth/4*3, height: helpScreen/3)
        commentTextField.layer.borderWidth = 0.5
        commentTextField.layer.borderColor = UIColor.brown.cgColor
        commentTextField.text = ""
        self.view.addSubview(commentTextField)
        
        //ok button
        okButton.setTitle("Ок", for: .normal)
        okButton.setTitleColor(.black, for: .normal)
        okButton.layer.borderColor = UIColor.gray.cgColor
        okButton.layer.borderWidth = 0.5
        okButton.frame = CGRect(x: screenWidth/4*3, y: helpScreen/3*2 +  (self.navigationController?.navigationBar.bounds.height)! * 2.1, width: screenWidth/4, height: helpScreen/3)
        okButton.addTarget(self, action: #selector(removeKeyBoard(sender:)), for: .touchDown)
        self.view.addSubview(okButton)
        
        //category picker
        categoryPicker.frame = CGRect(x: 0, y: helpScreen/3 +  (self.navigationController?.navigationBar.bounds.height)! * 1.5, width: screenWidth, height: helpScreen/6)
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        self.view.addSubview(categoryPicker)
        
        //date picker
        datePicker.frame = CGRect(x: 0, y: helpScreen/3*2 +  (self.navigationController?.navigationBar.bounds.height)!, width: screenWidth, height: helpScreen/6.2)
        datePicker.datePickerMode = .date
        self.view.addSubview(datePicker)
    }
    
    //MARK: - add other buttons
    func addButtons() {
        
        //screen bound
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //saveButton
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.borderColor = UIColor.gray.cgColor
        saveButton.layer.borderWidth = 0.5
        saveButton.frame = CGRect(x: 0, y: helpScreen + 1 * screenWidth/4, width: screenWidth/4, height: screenWidth/4)
        saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchDown)
        
        //emptyButton
        emptyButton.setTitle("C", for: .normal)
        emptyButton.setTitleColor(.black, for: .normal)
        emptyButton.layer.borderColor = UIColor.gray.cgColor
        emptyButton.layer.borderWidth = 0.5
        emptyButton.frame = CGRect(x: 0, y: helpScreen + 2 * screenWidth/4, width: screenWidth/4, height: screenWidth/4)
        emptyButton.addTarget(self, action: #selector(deleteLastDigit(sender:)), for: .touchDown)
        
        //add buttons on the view
        self.view.addSubview(saveButton)
        self.view.addSubview(emptyButton)
    }
    
    //MARK: - save
    @objc func save(sender: UIButton) {
        let companents = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        var date = String(companents.day!)+"."
        if companents.month!<10 {
            date = date+"0"+String(companents.month!)+"."+String(companents.year!)
        }
        else {
            date = date+String(companents.month!)+"."+String(companents.year!)
        }
        let category = self.pickerView(categoryPicker, titleForRow: categoryPicker.selectedRow(inComponent: 0), forComponent: 0)!
        elementAdd = ArrayClass(date1: date, category1: category, sum1: sumLabel.text!, comment1: commentTextField.text)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Costs", in: context)
        let newElement = NSManagedObject(entity: entity!, insertInto: context)
        
        newElement.setValue(elementAdd.sum, forKey: "sum")
        newElement.setValue(elementAdd.date, forKey: "date")
        newElement.setValue(elementAdd.comment, forKey: "comment")
        newElement.setValue(elementAdd.category, forKey: "category")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        costArray.append(newElement)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - addDigitElements
    func addDigitElements() {
        let zeroDigitButton = UIButton()
        zeroDigitButton.setTitle("0", for: .normal)
        zeroDigitButton.setTitleColor(.black, for: .normal)
        zeroDigitButton.layer.borderColor = UIColor.gray.cgColor
        zeroDigitButton.layer.borderWidth = 0.5
        //digitButton.titleLabel?.sizeThatFits()
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        zeroDigitButton.frame = CGRect(x: 0, y: helpScreen + 3 * screenWidth/4, width: screenWidth/4, height: screenWidth/4)
        self.view.addSubview(zeroDigitButton)
        digitArray.append(zeroDigitButton)
        for i in 0...8 {
            let digitButton = UIButton()
            digitButton.setTitleColor(.black, for: .normal)
            digitButton.layer.borderColor = UIColor.gray.cgColor
            digitButton.setTitle(String(i + 1), for: .normal)
            digitButton.layer.borderWidth = 0.5
            digitButton.frame = CGRect(x: CGFloat(screenWidth/4 * CGFloat(i % 3 + 1)), y: CGFloat(helpScreen + screenWidth/4 * CGFloat(i / 3 + 1)), width: screenWidth/4, height: screenWidth/4)
            digitArray.append(digitButton)
        }
        print(digitArray.count)
        for i in 0...9 {
            digitArray[i].addTarget(self, action: #selector(addDigit(sender:)), for: .touchDown)
            view.addSubview(digitArray[i])
        }
    }
    
    //MARK: - remove keyboard
    @objc func removeKeyBoard(sender: UIButton) {
        commentTextField.resignFirstResponder()
    }
    
    //MARK: - add digit to the label
    @objc func addDigit(sender: UIButton) {
        var str = sumLabel.text
        str = str! + sender.currentTitle!
        sumLabel.text = str
    }
    
    //MARK: - delete digit
    @objc func deleteLastDigit(sender: UIButton) {
        let str = sumLabel.text?.dropLast()
        sumLabel.text = String(str!)
    }
}

extension AddCostViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let size = categoryArray.count
        return size
    }
}

extension AddCostViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = categoryArray[row]
        return result
    }
}

