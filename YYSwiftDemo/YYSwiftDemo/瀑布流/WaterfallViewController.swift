//
//  WaterfallViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/22.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class WaterfallViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, WaterfallFlowLayoutDelegate{
    
    var heightArray: Array<CGFloat>!
    
    lazy var flowLayout: WaterFallFlowLayout = WaterFallFlowLayout()
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        heightArray = []
        for _ in 0..<100 {
            let randm = CGFloat(arc4random_uniform(300))
            heightArray.append(randm)
        }
        
        self.initUI()
        self.initSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Delegate
    func getCellHeight(index: Int) -> CGFloat {
        return heightArray[index]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heightArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = randomColor()
        return cell
    }
    
    
    
    func initUI() {
        
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHTE - 200)
        
        collectionView = UICollectionView.init(frame: rect, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.flowLayout.delegate = self
        self.flowLayout.hItemSpace = 10
        self.flowLayout.vItemSpace = 10
        self.flowLayout.lineCount = 10
        self.flowLayout.edge = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
    }
    
    func initSlider() {
        let rect = CGRect(x: 0, y: SCREEN_HEIGHTE - 200, width: SCREEN_WIDTH, height: 200)
        let view = UIView.init(frame: rect)
        self.view.addSubview(view)

        for i in 0..<3 {
            let hSlider = UISlider.init(frame: CGRect(x: 50, y: 60 + 60 * i, width:Int(SCREEN_WIDTH - 100), height: 20))
            hSlider.tag = i + 100;
            hSlider.maximumValue = 20;
            hSlider.minimumValue = 0;
            hSlider.addTarget(self, action: #selector(sliderChaneged(slider:)), for: .valueChanged)
            view.addSubview(hSlider)
            
            switch i {
            case 0:
                hSlider.value = Float(self.flowLayout.hItemSpace)
            case 1:
                hSlider.value = Float(self.flowLayout.vItemSpace)
            default:
                hSlider.value = Float(self.flowLayout.lineCount) * 2
            }
        }
        
    }
    
    func sliderChaneged(slider: UISlider){
        if slider.tag == 100 {
            self.flowLayout.hItemSpace = CGFloat(slider.value)
        } else if slider.tag == 101 {
            self.flowLayout.vItemSpace = CGFloat(slider.value)
        } else if slider.tag == 102 {
            self.flowLayout.lineCount = Int(slider.value / 2)
        }
    }
    
    


}
