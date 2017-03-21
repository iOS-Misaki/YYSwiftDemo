//
//  MaskBtnView.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/20.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

protocol MaskBtnViewDelegate {
    func getPoint(point: CGPoint, index: Int) -> ()
}

class MaskBtnView: UIView {
    
    var delegate: MaskBtnViewDelegate?
    
    var backgroundView: UIView!
    var forwardView: UIView!
    var maskLayer: CALayer!
    
    var backgroundTextColor: UIColor = UIColor.black
    var forwarkTextColor: UIColor = UIColor.white
    var forwarkViewBackgroundColor: UIColor = UIColor.red
    var textFont: UIFont = UIFont.boldSystemFont(ofSize: 18)
    
    var lastIndex = 0
    
    var textArray: Array<String>! = ["Misaki","Tom","Jerry"] {
        didSet {
            backgroundView.removeFromSuperview()
            initUI()
        }
    }
    
    var subViewWidth: CGFloat {
        get {
            return self.frame.size.width / CGFloat(textArray.count)
        }
    }
    
    var subViewHeight: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initUI() {
        addBackgroundView()
        addForwarkView()
        addSubBtns()
    }
    
    func addBackgroundView() {
        backgroundView = UIView.init(frame: self.bounds)
        self.addSubview(backgroundView)
        
        for i in 0..<textArray.count {
            let backgroundLab = UILabel.init(frame: getSubViewFrame(index: i))
            backgroundLab.text = textArray[i]
            backgroundLab.textColor = backgroundTextColor
            backgroundLab.font = textFont
            backgroundLab.textAlignment = .center
            backgroundView.addSubview(backgroundLab)
        }
    }
    
    func addForwarkView() {
        forwardView = UIView.init(frame: self.bounds)
        forwardView.backgroundColor = forwarkViewBackgroundColor
        backgroundView.addSubview(forwardView)
        
        for i in 0..<textArray.count {
            let forwardLab = UILabel.init(frame: getSubViewFrame(index: i))
            forwardLab.text = textArray[i]
            forwardLab.textColor = forwarkTextColor
            forwardLab.font = textFont
            forwardLab.textAlignment = .center
            forwardView.addSubview(forwardLab)
        }
        
        addMaskLayer()
    }
    
    func addMaskLayer() {
        maskLayer = CALayer()
        maskLayer.frame = getSubViewFrame(index: 0)
        maskLayer.cornerRadius = 25
        maskLayer.backgroundColor = forwarkViewBackgroundColor.cgColor
        forwardView.layer.mask = maskLayer
    }
    
    func addSubBtns() {
        for i in 0..<textArray.count {
            let btn = UIButton.init(frame: getSubViewFrame(index: i))
            btn.tag = i
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            self.addSubview(btn)
        }
    }
    
    func getSubViewFrame(index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * subViewWidth, y: 0, width: subViewWidth, height: subViewHeight)
    }
    
    
    func btnClick(sender: UIButton) {
//        maskLayer.frame = getSubViewFrame(index: sender.tag)
        
        let width = maskLayer.frame.size.width
        
        let animation = CABasicAnimation(keyPath:"position.x")
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = getSubViewFrame(index: lastIndex).origin.x + width / 2
        animation.toValue = getSubViewFrame(index: sender.tag).origin.x + width / 2
        maskLayer.add(animation, forKey: "translate")
        
        lastIndex = sender.tag
        
        if delegate != nil {
            delegate?.getPoint(point: getSubViewFrame(index: lastIndex).origin, index: lastIndex)
        }
    }
    
}





























