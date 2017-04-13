//
//  ScanerView.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/30.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class ScanerView: UIView {

    let squareView = UIView.init(frame: OCCGRect(SCREEN_WIDTH * 0.2, SCREEN_HEIGHTE * 0.35, SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.6))
    
    let scanLine = UIImageView()
    
    var scanning: String!
    
    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        squareView.layer.borderWidth = 1.0
        squareView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(squareView)
        
        //扫描线
        scanLine.frame = OCCGRect(0, 0, squareView.frame.size.width, 5)
        scanLine.image = UIImage(named:"line")
        
        squareView.addSubview(scanLine)
        
        createBackgroundView()
        
        self.addObserver(self, forKeyPath: "scanning", options: .new, context: nil)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveScannerLayer(_:)), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBackgroundView() {
        let topView = UIView.init(frame: OCCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHTE * 0.35))
        let bottomView = UIView.init(frame: OCCGRect(0, SCREEN_WIDTH * 0.6 + SCREEN_HEIGHTE * 0.35, SCREEN_WIDTH, SCREEN_HEIGHTE * 0.65 - SCREEN_WIDTH * 0.6))
        let leftView = UIView.init(frame: OCCGRect(0, SCREEN_HEIGHTE * 0.35, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.6))
        let rightView = UIView.init(frame: OCCGRect(SCREEN_WIDTH * 0.8, SCREEN_HEIGHTE * 0.35, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.6))
        
        topView.backgroundColor = RGBA(R: 0, G: 0, B: 0, A: 0.4)
        bottomView.backgroundColor = RGBA(R: 0, G: 0, B: 0, A: 0.4)
        leftView.backgroundColor = RGBA(R: 0, G: 0, B: 0, A: 0.4)
        rightView.backgroundColor = RGBA(R: 0, G: 0, B: 0, A: 0.4)
        
        let label = UILabel.init(frame: OCCGRect(0, 10, SCREEN_WIDTH, 21))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.text = "将二维码放入扫描框内，即可自动扫描"
        
        bottomView.addSubview(label)
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if scanning == "start" {
            timer.fire()
        } else {
            timer.invalidate()
        }
    }
    
    func  moveScannerLayer(_ timer: Timer) {
        scanLine.frame = OCCGRect(0, 0, squareView.frame.size.width, 12)
        UIView.animate(withDuration: 2) { 
            self.scanLine.frame = OCCGRect(x(self.scanLine), y(self.scanLine) + h(self.squareView) - 10, w(self.scanLine), h(self.scanLine))
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
