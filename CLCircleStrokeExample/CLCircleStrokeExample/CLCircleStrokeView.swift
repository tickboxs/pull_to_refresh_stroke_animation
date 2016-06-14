//
//  CLCircleStrokeView.swift
//  CLCircleStrokeExample
//
//  Created by 蔡磊 on 16/6/14.
//  Copyright © 2016年 cailei. All rights reserved.
//

import UIKit

class CLCircleStrokeView: UIView {
    //MARK:init
    init(){
        super.init(frame: CGRectZero)
        
        prepareView()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:lazy loading
    lazy var shapeLayer = CAShapeLayer()
    
    var isAnimating = false
    
    //MARK:progress setter
    var progress:CGFloat {
        set(newValue) {
            self.shapeLayer.strokeEnd = newValue
        }
        get{
            return 1
        }
    }
    
    //MARK:UI
    private func prepareView() -> Void{
        self.layer.addSublayer(shapeLayer)
        
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 1
        
    }
    
    private func setupUI() -> Void{
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shapeLayer.frame = self.bounds
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width*0.5, y: self.bounds.height*0.5), radius: self.bounds.width*0.5-5, startAngle: 0, endAngle: CGFloat(M_PI*2)-0.3, clockwise: true).CGPath
        
    }
    
    //MARK:animation
    func startRotation() -> Void{

        let rotationAtStart = self.shapeLayer.valueForKeyPath("transform.rotation")
//        let myRotationTransform  = CATransform3DRotate(shapeLayer.transform, CGFloat(M_PI)*2-0.01, 0.0, 0.0, 1.0)
//        shapeLayer.transform = myRotationTransform
        
        let infiniteRotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

        infiniteRotationAnimation.duration = 1
        infiniteRotationAnimation.repeatCount = MAXFLOAT
        infiniteRotationAnimation.fromValue = rotationAtStart
        infiniteRotationAnimation.toValue = NSNumber(float: (rotationAtStart?.floatValue)! + Float(M_PI)*2-0.01)
        shapeLayer.addAnimation(infiniteRotationAnimation, forKey: "transform.rotation")
        
        self.isAnimating = true
    }
    
    func endRotation() -> Void{
        self.shapeLayer.removeAnimationForKey("transform.rotation")
    }
}
