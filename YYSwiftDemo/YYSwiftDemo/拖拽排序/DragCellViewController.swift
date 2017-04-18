//
//  DragCellViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/28.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class DragCellViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    var dataArray: Array<String>!
    
    var longPress: UILongPressGestureRecognizer!
    
    lazy var dragCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 30) / 3, height: 50)
        
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = randomColor()
        collectionView.register(DragCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //iOS 9.0 以上才会有这个API
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func longPressTap(sender: UILongPressGestureRecognizer) {
        
        switch sender.state {
        case .began:
            let point = sender.location(in: dragCollectionView)
            let selectedIndexPath = dragCollectionView.indexPathForItem(at: point)
            
            if selectedIndexPath != nil {
                //发现有时候会有 selectedIndexPath 为空的时候
                if #available(iOS 9.0, *) {
                    dragCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath!)
                } else {
                    // Fallback on earlier versions
                }
            }
            
        case .changed:
            let point = sender.location(in: dragCollectionView)
            if #available(iOS 9.0, *) {
                dragCollectionView.updateInteractiveMovementTargetPosition(point)
            } else {
                // Fallback on earlier versions
            }
        case .ended:
            if #available(iOS 9.0, *) {
                dragCollectionView.endInteractiveMovement()
            } else {
                // Fallback on earlier versions
            }
        default: break
            
        }
        
    }
    
    
    func setData() {
        
        dataArray = Array<String>()
        
        for i in 0..<30 {
            let string = "\(i)"
            dataArray.append(string)
        }
        
        longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressTap(sender:)))
        dragCollectionView.addGestureRecognizer(longPress)
        
        self.view.backgroundColor = randomColor()
        self.view.addSubview(dragCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DragCell
        cell.label.text = dataArray[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dPrint(item: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = dragCollectionView.cellForItem(at: destinationIndexPath)
        cell?.contentView.backgroundColor = randomColor()
        
        let temp = dataArray[sourceIndexPath.item]
        dataArray.remove(at: sourceIndexPath.item)
        dataArray.insert(temp, at: destinationIndexPath.item)
    }


}
