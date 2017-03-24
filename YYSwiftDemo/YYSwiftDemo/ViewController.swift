//
//  ViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/16.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let itemArray = ["视差错觉","瀑布流（WaterFall）","滚动视差（Parallax）","拖拽排序（MoveCell）","暂时没有（点我刷新）"]
    
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


}

