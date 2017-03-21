//
//  MaskBtnViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/20.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class MaskBtnViewController: UIViewController ,MaskBtnViewDelegate{
    
    var backlab: UILabel!
    var forwardLab: UILabel!
    var maskeLayer: CALayer!
    
    var lastX: CGFloat!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = randomColor()
        
        let rect = CGRect(x: 0, y: 64 + 20, width: SCREEN_WIDTH, height: 50)
        let maskBtnView = MaskBtnView.init(frame: rect)
        maskBtnView.textArray = ["Misaki","Yuki","Tom","Jerry"]
        maskBtnView.delegate = self
        self.view.addSubview(maskBtnView)
        
        initUI()
    }
    
    func getPoint(point: CGPoint, index: Int) {
        let width = maskeLayer.frame.size.width
        
        let animation = CABasicAnimation(keyPath:"position.x")
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = lastX  + width / 2
        animation.toValue = point.x + width / 2
        maskeLayer.add(animation, forKey: "translate")
        
        lastX = point.x
    }
    
    func initUI() {
        
        let text = "Hello Misaki"
        let rect = CGRect(x: 0, y: 64 + 20 + 100, width: SCREEN_WIDTH, height: 80)
        let font = UIFont.boldSystemFont(ofSize: 35)
        
        backlab = UILabel.init(frame: rect)
        backlab.text = text
        backlab.font = font
        backlab.textAlignment = .center
        backlab.textColor = UIColor.yellow
        self.view.addSubview(backlab)
        
        forwardLab = UILabel.init(frame: rect)
        forwardLab.text = text
        forwardLab.font = font
        forwardLab.textAlignment = .center
        forwardLab.textColor = UIColor.green
        self.view.addSubview(forwardLab)
        
        
        maskeLayer = CALayer()
        maskeLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        maskeLayer.cornerRadius = 10
        maskeLayer.backgroundColor = UIColor.green.cgColor
        forwardLab.layer.mask = maskeLayer
        
        lastX = 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
