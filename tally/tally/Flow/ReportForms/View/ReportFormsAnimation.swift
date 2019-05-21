//
//  ReportFormsAnimation.swift
//  SwiftTest
//
//  Created by zykj on 2019/5/20.
//  Copyright © 2019 zykj. All rights reserved.
//

import UIKit

class ReportFormsAnimation: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
   public var params: Array<Any> = Array.init()
   private let radius: CGFloat = 60;
   private let offsetX: CGFloat = 70;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loadData()
    }
    
    init() {
        super.init(frame: CGRect.zero)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> Void {
        
        self.backgroundColor = UIColor.white
        
        let centerView: UIView = UIView.init()
        centerView.backgroundColor = UIColor.white
        centerView.frame = CGRect.init(x: 0, y: 0, width: radius * 2 - 50, height: radius * 2 - 50)
        centerView.layer.cornerRadius = (radius * 2 - 50) / 2.0
        self.addSubview(centerView)
        centerView.center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
        
        
    }
    
    
    private func loadData() -> Void {
        
        let dic: Dictionary = ["startAngle": 10.00, "endAngle": -120.00, "color": UIColor.red, "text" : "购房30%"] as [String : Any]
        let dic1: Dictionary = ["startAngle": -120.00, "endAngle": -210.00, "color": UIColor.blue, "text" : "车补30%"] as [String : Any]
        let dic2: Dictionary = ["startAngle": -210.00, "endAngle": -270.00, "color": UIColor.orange, "text" : "吃饭30%"] as [String : Any]
        let dic3: Dictionary = ["startAngle": -270.00, "endAngle": -300.00, "color": UIColor.cyan, "text" : "出行30%"] as [String : Any]
        let dic4: Dictionary = ["startAngle": -300.00, "endAngle": -330.00, "color": UIColor.black, "text" : "零食烟酒30%"] as [String : Any]
        let dic5: Dictionary = ["startAngle": -330.00, "endAngle": -350.00, "color": UIColor.lightGray, "text" : "其他30%"] as [String : Any]

        
        self.params.append(dic)
        self.params.append(dic1)
        self.params.append(dic2)
        self.params.append(dic3)
        self.params.append(dic4)
        self.params.append(dic5)

    }
    

    override func draw(_ rect: CGRect) {
        
        let context: CGContext! = UIGraphicsGetCurrentContext()
        
        for dic: Any in self.params {
            
            let dictionary: Dictionary = dic as! Dictionary<String, Any>
            let color: UIColor = dictionary["color"] as! UIColor
            let startAngle: Double = dictionary["startAngle"] as! Double
            let endAngle: Double = dictionary["endAngle"] as! Double
            let text: String = dictionary["text"] as! String
            
            context.setFillColor(color.cgColor)
            context.move(to: CGPoint.init(x: self.bounds.midX, y: self.bounds.midY))
            context.addArc(center: CGPoint.init(x: self.bounds.midX, y: self.bounds.midY), radius: radius, startAngle:(CGFloat)(startAngle * Double.pi / 180.0), endAngle: (CGFloat)(endAngle * Double.pi / 180.0), clockwise: true)
            context.closePath()
            context.drawPath(using: CGPathDrawingMode.fill)
            
            
            var y: CGFloat = (radius + 10) * CGFloat(sin(((endAngle - startAngle) / 2.0  + startAngle) * Double.pi / 180.0))
            var x: CGFloat = (radius + 10) * CGFloat(cos(((endAngle - startAngle) / 2.0 + startAngle) * Double.pi / 180.0))
            x += self.bounds.midX
            y += self.bounds.midY
            
           
            
            
            
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(1)
            context.addArc(center: CGPoint.init(x: x, y: y), radius: 5, startAngle: 0, endAngle: CGFloat.init(2 * Double.pi), clockwise: false)
            context.closePath()
            context.drawPath(using: CGPathDrawingMode.stroke)
            
            context.setFillColor(color.cgColor)
            context.addArc(center: CGPoint.init(x: x, y: y), radius: 3, startAngle: 0, endAngle: CGFloat.init(2 * Double.pi), clockwise: false)
            context.drawPath(using: CGPathDrawingMode.fill)
            
            
            
            var y1: CGFloat = (radius + 30) * CGFloat(sin(((endAngle - startAngle) / 2.0  + startAngle) * Double.pi / 180.0))
            var x1: CGFloat = (radius + 30) * CGFloat(cos(((endAngle - startAngle) / 2.0 + startAngle) * Double.pi / 180.0))
            x1 += self.bounds.midX
            y1 += self.bounds.midY
            
            var points:Array<CGPoint> = Array.init();
            let point1: CGPoint = CGPoint.init(x: x, y: y)
            points.append(point1)
            
            var point2: CGPoint! = CGPoint.zero
            var point3: CGPoint! = CGPoint.zero
            var point4: CGPoint! = CGPoint.zero
            if x >= self.bounds.midX && y >= self.bounds.midY{
//                point2 = CGPoint.init(x: x + 15, y: y + 15)
                point2 = CGPoint.init(x: x1, y: y1)
                points.append(point2)
//                point3 = CGPoint.init(x: point2.x + offsetX, y: point2.y)
                point3 = CGPoint.init(x: self.bounds.maxX - 15, y: point2.y)
                points.append(point3)
                point4 = CGPoint.init(x: point3.x - lengthOf(text), y: point3.y - 15)
            }else if x >= self.bounds.midX && y <= self.bounds.midY{
//                point2 = CGPoint.init(x: x + 15, y: y - 15)
                point2 = CGPoint.init(x: x1, y: y1)
                points.append(point2)
//                point3 = CGPoint.init(x: point2.x + offsetX, y: point2.y)
                point3 = CGPoint.init(x: self.bounds.maxX - 15, y: point2.y)
                points.append(point3)
                point4 = CGPoint.init(x: point3.x - lengthOf(text), y: point3.y - 15)
            }else if x <= self.bounds.midX && y >= self.bounds.midY{
//                point2 = CGPoint.init(x: x - 15, y: y + 15)
                point2 = CGPoint.init(x: x1, y: y1)
                points.append(point2)
//                point3 = CGPoint.init(x: point2.x - offsetX, y: point2.y)
                point3 = CGPoint.init(x: 15, y: point2.y)
                points.append(point3)
                point4 = CGPoint.init(x: point3.x, y: point3.y - 15)

            }else if x <= self.bounds.midX && y <= self.bounds.midY{
//                point2 = CGPoint.init(x: x - 15, y: y - 15)
                point2 = CGPoint.init(x: x1, y: y1)
                points.append(point2)
//                point3 = CGPoint.init(x: point2.x - offsetX, y: point2.y)
                point3 = CGPoint.init(x: 15, y: point2.y)
                points.append(point3)
                point4 = CGPoint.init(x: point3.x, y: point3.y - 15)

            }
            
            context.addLines(between: points)
            context.setStrokeColor(color.cgColor)
            context.drawPath(using: CGPathDrawingMode.stroke)
            
            let attribute: Dictionary = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
            (text as NSString).draw(in: CGRect.init(x: point4.x, y: point4.y, width: lengthOf(text), height: 15), withAttributes: attribute)
            
            
        
            
        }
        
    }
    
    func lengthOf(_ text:String) -> CGFloat {
        let rect = (text as NSString).boundingRect(with: CGSize.init(width: 0, height: 15), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], context: nil)
        return rect.width
    }
    
}
