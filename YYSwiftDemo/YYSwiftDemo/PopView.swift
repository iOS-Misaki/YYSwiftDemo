//
//  PopView.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/4/1.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class PopView: UIView , UIGestureRecognizerDelegate{
    
    lazy var containerView: UIView = {
        //在APP的底部
        let view = UIView.init(frame: OCCGRect(20, SCREEN_HEIGHTE + SCREEN_HEIGHTE / 2 - 100, SCREEN_WIDTH - 40, 200))
        view.backgroundColor = UIColor.white
        
//        let ges = UITapGestureRecognizer.init(target: self, action: #selector(containerTouch(sender:)))
//        view.addGestureRecognizer(ges)
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: containerView))! {
            return false
        }
        
        return true
    }
    
    func setUp() {
        self.frame = OCCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHTE)
        self.backgroundColor = RGBA(R: 0, G: 0, B: 0, A: 0.8)
        self.isUserInteractionEnabled = true
        
        let ges = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTouch(sender:)))
        ges.delegate = self
        self.addGestureRecognizer(ges)
        
        self.addSubview(containerView)
        
        UIView.animate(withDuration: 0.3) { 
            self.containerView.frame = OCCGRect(20, SCREEN_HEIGHTE / 2 - 100, SCREEN_WIDTH - 40, 200)
        }
        
    }
    
    func backgroundTouch(sender: UITapGestureRecognizer) {
        
        dismiss()
        
    }
    
    func containerTouch(sender: UITapGestureRecognizer) {
        
    }
    
    open func showInView(superView: UIView) {
        superView.addSubview(self)
    }
    
    open func showInWindow() {
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.containerView.frame = OCCGRect(0, SCREEN_HEIGHTE, SCREEN_WIDTH, 200)
            self.alpha = 0
        }) { (finish) in
            if finish {
                self.removeFromSuperview()
            }
        }
    }
    
    

}
