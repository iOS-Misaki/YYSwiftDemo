//
//  Global.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/16.
//  Copyright © 2017年 余意. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_HEIGHTE = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width

let SYSTEM_VERSION = UIDevice.current.systemVersion._bridgeToObjectiveC().doubleValue


func randomColor() -> UIColor {
    return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
}

func randomValue() -> CGFloat {
    return CGFloat(arc4random_uniform(256))/255
}

func RGBA(R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat) -> UIColor {
    return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: A)
}

func x(_ object: UIView) -> CGFloat {
    return object.frame.origin.x
}

func y(_ object: UIView) -> CGFloat {
    return object.frame.origin.y
}

func w(_ object: UIView) -> CGFloat {
    return object.frame.size.width
}

func h(_ object: UIView) -> CGFloat {
    return object.frame.size.height
}

func OCCGRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func OCCGSize(_ width: CGFloat, _ height: CGFloat) -> CGSize {
    return CGSize(width: width, height: height)
}

func OCCGPoint(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
}

func OCCGRect(_ origin: CGPoint, _ size: CGSize) -> CGRect {
    return CGRect(origin: origin, size: size)
}


func dPrint(item:@autoclosure () -> Any) {
    #if DEBUG
    //之所以加上@autoclosure 是因为想延迟对传入的表达式的计算，进一步优化性能
    print(item())
    #endif
}
