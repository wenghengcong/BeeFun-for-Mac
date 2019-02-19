//
//  UIView+Animation.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/28.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import AppKit

extension NSView {
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer?.animation(forKey: NSView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = NSNumber(value: 0.0)
            rotationAnimation.toValue = Float.pi * 2.0
//            NSNumber(value: (Double(arc4random() % 360) * Double.pi / 180.0))
            rotationAnimation.duration = duration
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//            rotationAnimation.fillMode = kCAFillModeForwards
            rotationAnimation.repeatCount = Float.infinity
            layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            layer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            layer?.add(rotationAnimation, forKey: NSView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer?.animation(forKey: NSView.kRotationAnimationKey) != nil {
            layer?.removeAnimation(forKey: NSView.kRotationAnimationKey)
        }
    }
}
