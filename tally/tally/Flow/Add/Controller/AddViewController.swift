//
//  AddViewController.swift
//  tally
//
//  Created by 李志敬 on 2019/3/7.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, ConsumeTypeViewDelegate, KeyboardViewDelegate, RemarkViewDelegate {

    enum MovementSpaceType {
        case increasingY
        case pointY
    }
    
     // MARK: - Property
    
    var consumeTypeView: ConsumeTypeView?
    var topView: AddTopView?
    var keyboardView: KeyboardView?
    var inputAmountView: Add_InputAmountView?
    var remarkView: RemarkView?
    var isSwitchFirstResponder: Bool = true
    
     // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: UITouch in touches {
            
            let length: CGFloat = touch.location(in: UIApplication.shared.delegate?.window ?? UIView.init()).y - touch.previousLocation(in: UIApplication.shared.delegate?.window ?? UIView.init()).y
            movement(value: length, type: MovementSpaceType.increasingY)
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        movementEnd()
        
    }
    
    
    

     // MARK: - SetupUI
    
    func setupUI() -> Void {
                
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        self.view.backgroundColor = UIColor.white
        
        let topView:AddTopView = AddTopView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationHeight))
        self.navigationController?.view.addSubview(topView)
        topView.backBtnCallback {
            self.dismiss(animated: true, completion: {
                
            })
        }
        topView.segmentCallback { (index: Int) in
            
        }
        self.topView = topView
        
        let inputAmountView: Add_InputAmountView = Add_InputAmountView.init(frame: CGRect.init(x: 0, y: topView.frame.maxY, width: kScreenWidth, height: 70))
        self.view.addSubview(inputAmountView)
        self.inputAmountView = inputAmountView
        
        let lineView: UIView = UIView.init()
        lineView.backgroundColor = UIColor.init(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        self.view.addSubview(lineView)
        lineView.frame = CGRect.init(x: 0, y: inputAmountView.frame.maxY, width: kScreenWidth, height: 10)
        
        let consumeTypeView: ConsumeTypeView = ConsumeTypeView.init(frame: CGRect.init(x: 0, y: lineView.frame.maxY, width: kScreenWidth, height: 150))
        consumeTypeView.delegate = self
        self.view.addSubview(consumeTypeView)
        self.consumeTypeView = consumeTypeView
        
        let selectDateView: SelectDateView = SelectDateView.init(frame: CGRect.init(x: 10, y: consumeTypeView.frame.maxY + 5, width: 60, height: 30))
        self.view.addSubview(selectDateView)
        
        let remarkView: RemarkView = RemarkView.init(frame: CGRect.init(x: selectDateView.frame.maxX + 10, y: consumeTypeView.frame.maxY + 5, width: kScreenWidth - selectDateView.frame.maxX - 10 - 10, height: 30))
        remarkView.delegate = self
        self.view.addSubview(remarkView)
        self.remarkView = remarkView
        
        let keyboard: KeyboardView = KeyboardView.init(frame: CGRect.init(x: 0, y: kScreenHeight - 220 - kBottomSafeAreaHeight, width: kScreenWidth, height: 220))
        keyboard.delegate = self
//        self.navigationController?.view.addSubview(keyboard)
        self.keyboardView = keyboard
        self.inputAmountView?.setInputView(aInputView: keyboard)
        
        
    }
    
    
    
     // MARK: - ConsumeTypeViewDelegate
    
    func consumeTypeViewPanGesture(ges: UIPanGestureRecognizer) {
        
        switch ges.state {
        case .changed:
            
            let point: CGPoint = ges.translation(in: self.view)
            movement(value: point.y, type: MovementSpaceType.pointY)
            
            break
        case .ended:
            movementEnd()
            break
        default: break
            
        }
        
    }
    
     // MARK: - Methods
    
    func movement(value: CGFloat, type: MovementSpaceType) -> Void {
        
        var frame: CGRect = self.view.frame
        
        if frame.origin.y > 0 {
            
            if type == MovementSpaceType.increasingY {
                frame.origin.y += value
            }
            
            if type == MovementSpaceType.pointY {
                frame.origin.y = value
            }
            
            var topViewFrame: CGRect = self.topView?.frame ?? CGRect.zero
            topViewFrame.origin.y = frame.origin.y
            self.topView?.frame = topViewFrame
            
            let hostView: UIView = getHostView()
            var keyboardFrame: CGRect = hostView.frame
            if frame.origin.y > kScreenHeight - keyboardFrame.height - 150   {
                keyboardFrame.origin.y = frame.origin.y + 150
            }else{
                keyboardFrame.origin.y = kScreenHeight - keyboardFrame.height - kBottomSafeAreaHeight
            }
            hostView.frame  = keyboardFrame

            
        }else{
            
            let decrease: CGFloat = 1 + (frame.origin.y / frame.height)
            
            if type == MovementSpaceType.increasingY {
                frame.origin.y += value * decrease * 0.6
            }
            
            if type == MovementSpaceType.pointY {
                frame.origin.y = value * decrease
            }
            
            var topViewFrame: CGRect = self.topView?.frame ?? CGRect.zero
            topViewFrame.origin.y = 0
            self.topView?.frame = topViewFrame
            
        }
        
        self.view.frame = frame
        
    }
    
    func restoreMovement() -> Void {
        
        var frame: CGRect = self.view.frame
        frame.origin.x = 0
        frame.origin.y = 0
        self.view.frame = frame
        
        var topViewFrame: CGRect = self.topView?.frame ?? CGRect.zero
        topViewFrame.origin = CGPoint.zero
        self.topView?.frame = topViewFrame
        
//        var keyboardFrame: CGRect = self.keyboardView?.frame ?? CGRect.zero
//        keyboardFrame.origin.y = kScreenHeight - keyboardFrame.height - kBottomSafeAreaHeight
//        self.keyboardView?.frame = keyboardFrame
        
        let  hostView: UIView = getHostView()
        var keyboardFrame: CGRect = hostView.frame
        keyboardFrame.origin.y = kScreenHeight - keyboardFrame.height - kBottomSafeAreaHeight
        hostView.frame  = keyboardFrame
        
    }
    
    func movementEnd() -> Void {
        
        let frame: CGRect = self.view.frame
        if frame.origin.y > kScreenHeight / 2.5 {
            self.navigationController?.view.backgroundColor = UIColor.clear
            self.isSwitchFirstResponder = false
            self.view.endEditing(true)
            self.dismiss(animated: true) {
                
            }
        }else{
            self.restoreMovement()
        }

        
    }
    
    func getHostView() -> UIView {
        
        
        var hostView: UIView?
        var containerView: UIView?
        let windowsArray =  UIApplication.shared.windows

        for window: UIWindow in windowsArray {

            let subArray = window.subviews

            for view: UIView in subArray {
                if view.description.hasPrefix("<UIInputSetContainerView"){
                    containerView = view
                    break
                }

            }

        }
        
        hostView = containerView?.subviews.first
        
        return hostView ?? UIView.init()
        
        
    }
    
     // MARK: - KeyboardViewDelegate
    
    func keyboardHandler(title: String, key: Key.KeyNumber) {
        
        var amount: String?
        
        switch key {
        case .delete:
            self.inputAmountView?.deleteInputTF()
           break
        case .done:
            break
        case .equal:
            amount = self.inputAmountView?.inputTFEditingResult() ?? ""
            break
        default:
            self.inputAmountView?.inputTF(append: title)
            break
        }
        
    }
    
     // MARK: - RemarkViewDelegate
    
    func remarkTV(beginEditing textView: UITextView) {
        
    }
    
    func remarkTV(endEditing textView: UITextView) {
        if self.isSwitchFirstResponder{
            self.inputAmountView?.inputTF?.becomeFirstResponder()
        }
    }
    
}
