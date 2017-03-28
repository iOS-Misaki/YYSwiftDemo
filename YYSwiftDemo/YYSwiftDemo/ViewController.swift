//
//  ViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/16.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let itemArray = ["视差错觉（Visual Illusion）","瀑布流（WaterFall）","滚动视差（Parallax）","拖拽排序（DragCell）","暂时没有（点我刷新）"]
    
    lazy var customTableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.classForCoder() , forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.itemArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20) 
        cell.backgroundColor = randomColor()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let MBVC = MaskBtnViewController()
            MBVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(MBVC, animated: true)
            
        } else if indexPath.row == 1 {
            
            let WVC = WaterfallViewController()
            WVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(WVC, animated: true)
            
        } else if indexPath.row == 2 {
            
            let PEVC = ParallaxEffectViewController()
            PEVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(PEVC, animated: true)
            
        } else if indexPath.row == 3 {
            
            let DCVC = DragCellViewController()
            DCVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(DCVC, animated: true)
            
        } else {
            
            reloadTableView()
            
        }
        
        
    }
    
    func reloadTableView() {
        
        self.customTableView.reloadData()
        
        let cells = self.customTableView.visibleCells as Array<UITableViewCell>
        
        let kheight = h(self.customTableView)
        
        //偏移系数
        let koffset: CGFloat = 1
        
        //阻尼系数(0~1)
        let kdamp: CGFloat = 0.9
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: -SCREEN_WIDTH * koffset, y: kheight)
        }
        
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 1, delay: 0.05 * Double(index), usingSpringWithDamping: kdamp, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }

    func swapTwoInts( a: inout Int, b: inout Int) {
        let temp = a
        a = b
        b = temp
    }
    
    func swapTwoString( a: inout String, b: inout String) {
        let temp = a
        a = b
        b = temp
    }
    
    func swapTwoValue<T>(a: inout T, b: inout T) {
        let temp = a
        a = b
        b = temp
    }
    
    //泛型不用指定具体的参数类型
    func test() {
        
        var c = 10
        var d = 10
        swapTwoInts(a: &c, b: &d)
//        swapTwoString(a: &"10", b: &"9")
        swapTwoValue(a: &c, b: &d)
        
        var string1 = "sjih"
        var string2 = "hisfb"
        swapTwoValue(a: &string1, b: &string2)
    }
    
    struct IntStack {
        var items: Array<Int> = []
        
        //入栈
        mutating func push(item: Int) {
            items.append(item)
        }
        //出栈
        mutating func pop() -> Int {
            return items.removeLast()
        }
    }
    
//    //泛型版本
//    struct Stack<Element> {
//        var items = [Element]()
//        
//        
//        mutating func push(item:Element) {
//            items.append(item)
//        }
//        
//        mutating func pop() -> Element {
//            return items.removeLast()
//        }
//    }
    
    
    // typealias 别名的用法
    func  distanceBetweenPoint(point: CGPoint, toPoint: CGPoint) -> Double {
        let dx = Double(toPoint.x - point.x)
        let dy = Double(toPoint.y - point.y)
        return sqrt(dx*dx + dy*dy)
    }
    
    typealias Location = CGPoint
    typealias Distance = Double
    
    func distanceBetweenPoin(point: Location, toPoint: Location) -> Distance {
        let dx = Double(toPoint.x - point.x)
        let dy = Double(toPoint.y - point.y)
        return sqrt(dx*dx + dy*dy)
    }
    
    //用 typealias 定义闭包
//    typealias sendValueClosure = (_ sendString: String) -> Void
//    var callBackString: sendValueClosure
    
    func UI() {
        let label = UILabel()
        self.view.addSubview(label)
        
        
        let point = OCCGPoint(0, 0)
        let size = OCCGSize(200, 40)
        label.frame = OCCGRect(point, size)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

