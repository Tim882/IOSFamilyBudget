//
//  ConverterViewController.swift
//  Family Budget Calculating
//
//  Created by Тимур on 09.10.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    var currencyArray = ["Доллары", "Рубли", "Евро"]
    var dollarCost = 60;
    var euroCost = 70;
    var digitArray = [UIButton]()
    let convertButton = UIButton()
    let emptyButton = UIButton()
    var fromCurrencyLabel = UILabel()
    var toCurrencyLabel = UILabel()
    var toCurrencyPicker = UIPickerView()
    var fromCurrencyPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Конвертер"
        self.view.backgroundColor = UIColor.white
        
        addDigitElements()
        addButtons()
        addElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - add income elements
    func addElements() {
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //add label
        fromCurrencyLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.6, width: screenWidth, height: helpScreen/6)
        fromCurrencyLabel.backgroundColor = .white
        fromCurrencyLabel.textColor = UIColor.black
        fromCurrencyLabel.text = ""
        fromCurrencyLabel.layer.borderColor = UIColor.gray.cgColor
        fromCurrencyLabel.layer.borderWidth = 0.5
        self.view.addSubview(fromCurrencyLabel)
        
        //from currency picker
        fromCurrencyPicker.frame = CGRect(x: 0, y: helpScreen/6+(self.navigationController?.navigationBar.bounds.height)! * 1.6, width: screenWidth, height: helpScreen/6.5)
        fromCurrencyPicker.dataSource = self
        fromCurrencyPicker.delegate = self
        self.view.addSubview(fromCurrencyPicker)
        
        //add to currency label
        toCurrencyLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!*1.6+helpScreen/3, width: screenWidth, height: helpScreen/6)
        toCurrencyLabel.backgroundColor = .white
        toCurrencyLabel.textColor = UIColor.black
        toCurrencyLabel.text = ""
        toCurrencyLabel.layer.borderColor = UIColor.gray.cgColor
        toCurrencyLabel.layer.borderWidth = 0.5
        self.view.addSubview(toCurrencyLabel)
        
        //to currency picker
        toCurrencyPicker.frame = CGRect(x: 0, y: helpScreen/3 + (self.navigationController?.navigationBar.bounds.height)! * 1.5+helpScreen/6, width: screenWidth, height: helpScreen/6.5)
        toCurrencyPicker.dataSource = self
        toCurrencyPicker.delegate = self
        self.view.addSubview(toCurrencyPicker)
    }
    
    //MARK: - add other buttons
    func addButtons() {
        
        //screen bound
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //saveButton
        convertButton.setTitle("Перевести", for: .normal)
        convertButton.setTitleColor(.black, for: .normal)
        convertButton.layer.borderColor = UIColor.gray.cgColor
        convertButton.layer.borderWidth = 0.5
        convertButton.frame = CGRect(x: 0, y: helpScreen + 1 * screenWidth/4, width: screenWidth/4, height: screenWidth/4)
        convertButton.addTarget(self, action: #selector(save(sender:)), for: .touchDown)
        
        //emptyButton
        emptyButton.setTitle("C", for: .normal)
        emptyButton.setTitleColor(.black, for: .normal)
        emptyButton.layer.borderColor = UIColor.gray.cgColor
        emptyButton.layer.borderWidth = 0.5
        emptyButton.frame = CGRect(x: 0, y: helpScreen + 2 * screenWidth/4, width: screenWidth/4, height: screenWidth/4)
        emptyButton.addTarget(self, action: #selector(deleteLastDigit(sender:)), for: .touchDown)
        
        //add buttons on the view
        self.view.addSubview(convertButton)
        self.view.addSubview(emptyButton)
    }
    
    //MARK: - addDigitElements
    func addDigitElements() {
        
        //screen bound
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let helpScreen = screenHeight - (self.navigationController?.navigationBar.bounds.height)! - screenWidth
        
        //zeroDigitButton initialize
        let zeroDigitButton = UIButton()
        zeroDigitButton.setTitle("0", for: .normal)
        zeroDigitButton.setTitleColor(.black, for: .normal)
        zeroDigitButton.layer.borderColor = UIColor.gray.cgColor
        zeroDigitButton.layer.borderWidth = 0.5
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
        
        for i in 0...9 {
            digitArray[i].addTarget(self, action: #selector(addDigit(sender:)), for: .touchDown)
            view.addSubview(digitArray[i])
        }
    }
    
    //MARK: - add digit to the label
    @objc func addDigit(sender: UIButton) {
        var str = fromCurrencyLabel.text
        str = str! + sender.currentTitle!
        fromCurrencyLabel.text = str
    }
    
    //MARK: - delete digit
    @objc func deleteLastDigit(sender: UIButton) {
        let str = fromCurrencyLabel.text?.dropLast()
        fromCurrencyLabel.text = String(str!)
    }
    
    //MARK: - convert
    @objc func save(sender: UIButton) {
        let fromCur = self.pickerView(fromCurrencyPicker, titleForRow: fromCurrencyPicker.selectedRow(inComponent: 0), forComponent: 0)!
        let toCur = self.pickerView(toCurrencyPicker, titleForRow: toCurrencyPicker.selectedRow(inComponent: 0), forComponent: 0)!
        if (fromCur == "Доллары" && toCur == "Рубли") {
            toCurrencyLabel.text = String(Int(fromCurrencyLabel.text!)!*60)
        }
        else if (fromCur == "Доллары" && toCur == "Евро") {
            toCurrencyLabel.text = String(Int(fromCurrencyLabel.text!)!*60/70)
        }
        else if (fromCur == "Евро" && toCur == "Доллары") {
            toCurrencyLabel.text = String(Int(fromCurrencyLabel.text!)!*70/60)
        }
        else if (fromCur == "Евро" && toCur == "Рубли") {
            toCurrencyLabel.text = String(Int(fromCurrencyLabel.text!)!*70)
        }
        else if (fromCur == "Рубли" && toCur == "Доллары") {
            toCurrencyLabel.text = String(Int(fromCurrencyLabel.text!)!/60)
        }
        else if (fromCur == "Рубли" && toCur == "Евро") {
            toCurrencyLabel.text = String(Int(fromCurrencyLabel.text!)!/70)
        }
    }
}

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let size = currencyArray.count
        return size
    }
}

extension ConverterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = currencyArray[row]
        return result
    }
}
