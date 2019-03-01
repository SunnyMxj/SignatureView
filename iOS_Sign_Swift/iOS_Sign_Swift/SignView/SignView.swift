//
//  SignView.swift
//  iOS_Sign_Swift
//
//  Created by Ryan on 2019/2/28.
//  Copyright © 2019 Ryan. All rights reserved.
//

import UIKit

class SignView: UIView {

    public var textColor: UIColor = UIColor.red
    
    public var _lineWidth: CGFloat = 3.0
    var lineWidth: CGFloat{
        set {
            _lineWidth = newValue
            self.bezierPath.lineWidth = _lineWidth
        }
        get {
            return _lineWidth
        }
    }
    
    private var points: [CGPoint] = Array.init(repeating: CGPoint.zero, count: 5)
    private var pointIndex = 0
    private var bezierPath: UIBezierPath = UIBezierPath.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        self.isMultipleTouchEnabled = false
        bezierPath.lineWidth = 3.0
    }
    
    override func draw(_ rect: CGRect) {
        textColor.setStroke()
        bezierPath.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pointIndex = 0
        points[pointIndex] = touches.first!.location(in: self)
        bezierPath.move(to: points[0])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        pointIndex = pointIndex + 1
        points[pointIndex] = touches.first!.location(in: self)
        if pointIndex == 4 {
            points[3] = CGPoint.init(x: (points[2].x + points[4].x)/2, y: (points[2].y + points[4].y)/2)
            bezierPath.move(to: points[0])
            bezierPath.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
            self.setNeedsDisplay()
            
            //reset new start to last end
            points[0] = points[3];
            points[1] = points[4];
            pointIndex = 1;
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pointIndex < 4 {
            pointIndex = pointIndex + 1
            points[pointIndex] = touches.first!.location(in: self)
            let to: CGPoint = points[pointIndex]
            var center: CGPoint?
            var from: CGPoint?
            if pointIndex > 1 {
                center = points[pointIndex - 1]
                from = points[pointIndex - 2]
            } else {
                from = points[pointIndex - 1]
            }
            if to.equalTo(from!) {
                bezierPath.addQuadCurve(to: CGPoint.init(x: to.x + 2, y: to.y + 2), controlPoint: from!)
            } else if center != nil {
                bezierPath.addCurve(to: to, controlPoint1: from!, controlPoint2: center!)
            } else {
                bezierPath.addQuadCurve(to: to, controlPoint: from!)
            }
            self.setNeedsDisplay()
        }
    }
    
    public func clear() {
        self.bezierPath.removeAllPoints()
        self.setNeedsDisplay()
    }

    public func getSignImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        if let signImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return signImage
        }
        return nil
    }
}
