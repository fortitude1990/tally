//
//  Add_InputAmountView.swift
//  tally
//
//  Created by 李志敬 on 2019/3/8.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class Add_InputAmountView: UIView, UITextFieldDelegate {

     // MARK: - Property
    
    var inputTF: UITextField?
    
    
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - SetupUI
    
    func setupUI(frame: CGRect) -> Void {
        
        self.layoutIfNeeded()
        
        let titleLabel: UILabel = UILabel.init()
        titleLabel.text = "账单金额"
        titleLabel.textColor = UIColor.init(red: 41/255.0, green: 37/255.0, blue: 51/255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.equalTo(self)
        }
        
        let amountTF: UITextField = UITextField.init()
        amountTF.textAlignment = NSTextAlignment.right
        amountTF.textColor = themeColor
        amountTF.font = UIFont.boldSystemFont(ofSize: 21)
        amountTF.delegate = self
        amountTF.text = "￥0.00"
        amountTF.inputView = UIView.init()
        amountTF.inputAccessoryView = UIView.init()
        self.addSubview(amountTF)
        amountTF.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.height.equalTo(40)
            make.left.equalTo(titleLabel.snp_rightMargin).offset(10)
            make.centerY.equalTo(titleLabel)
        }
        self.inputTF = amountTF
        self.inputTF?.becomeFirstResponder()
        
    }
    
     // MARK: - Methods
    
    func inputTF(append str: String) -> Void {
        
        self.inputTF?.becomeFirstResponder()
        
        var inputText: String = self.inputTF?.text ?? ""
        
        if inputText.count == 5 && (inputText.contains("0.00") ) {
            let string: String =  inputText.replacingOccurrences(of: "0.00", with: "")
            self.inputTF?.text = string
            self.inputTF?.text?.append(str)
            return
        }
        
        if inputText.count == 1{
            if str.contains("+") || str.contains("-") || str.contains(".") {
                return
            }
        }
        
        if inputText.last == "." || inputText.last == "+" || inputText.last == "-"{
            if str.contains("+") || str.contains("-") || str.contains(".") {
                self.inputTF?.deleteBackward()
            }
        }
        
        if inputText.count > 3{
            
            inputText = self.inputTF?.text ?? ""
            
            let subStringIndex: String.Index = inputText.lastIndex(of: ".") ?? inputText.endIndex
            let subString: String = String(inputText[subStringIndex ..< inputText.endIndex])
            if !subString.contains("+") && !subString.contains("-") && subString.count > 0{
                
                if str.contains(".") {
                    return
                }
                
                if str != "+" && str != "-"{
                    if subString.count >= 3{
                        return
                    }
                }
            }
            
        }
        
        
        self.inputTF?.text?.append(str)

    }
    
    
    func deleteInputTF() -> Void {
        
        self.inputTF?.becomeFirstResponder()
        
        if self.inputTF?.text?.count ?? 0 > 1{
            self.inputTF?.deleteBackward()
        }
        
        
    }
    
    func inputTFEditingResult() -> String {
        
        var finalAmount: String?
        let inputTFText: String = self.inputTF?.text ?? ""
        finalAmount = inputTFText.replacingOccurrences(of: "￥", with: "")
        if finalAmount?.last == "+" || finalAmount?.last == "-" || finalAmount?.last == "." {
            finalAmount?.removeLast()
        }
        
        let addArray:Array<String> = finalAmount?.components(separatedBy: "+") ?? []
        var sum: Float = 0
        for add:String in addArray {
            
            let reduceArray: Array<String> = add.components(separatedBy: "-")
            
            var sub: Float = 0
            for reduce:String in reduceArray{
                let reduceValue: Float = Float.init(reduce) ?? 0.00
                if sub == 0 {
                    sub = reduceValue
                }else{
                    sub -= reduceValue
                }
            }
            
            sum += sub
            
        }
        
        finalAmount = String(format: "%.2lf", sum)
        
        self.inputTF?.text = String(format: "￥%@", finalAmount ?? "0.00")
        
        return finalAmount ?? "0.00"
    }
    
    func setInputView(aInputView: UIView) -> Void {
        self.inputTF?.inputView = aInputView
    }
    
    func inputSetHostView() -> UIView {
        return self.inputTF?.inputView?.superview ?? UIView.init()
    }
    
    func tfIsFirstResponder() -> Bool {
        return self.inputTF?.isFirstResponder ?? false
    }
    
     // MARK: - UITextFiledDelegate
    
    
    

}

extension UITextField{
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuVC: UIMenuController! = UIMenuController.shared
        if menuVC != nil {
            menuVC.setMenuVisible(false, animated: false)
        }
        return false
    }
    
}

