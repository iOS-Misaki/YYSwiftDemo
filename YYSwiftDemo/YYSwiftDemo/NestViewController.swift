//
//  NestViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/29.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class NestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let KOriginX: CGFloat = 120;
    
    let grayColor = RGBA(R: 218, G: 218, B: 218, A: 1)
    
    let dataArray = [["title":"出团日期", "routeName":"线路名称一", "time":"2015/11/21", "num":"20", "price":"124.0", "code":"DAGSDSASA"],
                     ["title":"余位", "routeName":"线路名称二", "time":"2015/11/21", "num":"34", "price":"234", "code":"TAGDFASFAF"],
                     ["title":"价格", "routeName":"线路名称三", "time":"2015/11/21", "num":"12", "price":"634", "code":"GHGASDAS"],
                     ["title":"团代号", "routeName":"线路名称四", "time":"2015/11/56", "num":"54", "price":"632", "code":"DAADSFAD"]];
    
    
    var titleTableView: UITableView!
    var contentSV: UIScrollView!
    var contentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        automaticallyAdjustsScrollViewInsets = false
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        titleTableView = UITableView.init(frame: OCCGRect(0, 64 + 40, KOriginX, SCREEN_HEIGHTE - 64 - 40), style: .plain)
        titleTableView.delegate = self
        titleTableView.dataSource = self
        titleTableView.separatorStyle = .none
        titleTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "titleTableView")
        self.view.addSubview(titleTableView)
        
        contentSV = UIScrollView.init(frame: OCCGRect(KOriginX, 64, SCREEN_WIDTH - KOriginX, SCREEN_HEIGHTE - 64))
        contentSV.contentSize = OCCGSize(400, SCREEN_HEIGHTE - 64)
        contentSV.backgroundColor = UIColor.yellow
        contentSV.delegate = self
        contentSV.bounces = false
        self.view.addSubview(contentSV)
        
        let titleLab = createLab(x: 0, y: 64 + 10, width: KOriginX, title: "标题")
        self.view.addSubview(titleLab)
        
        contentTableView = UITableView.init(frame: OCCGRect(0, 40, 400, SCREEN_HEIGHTE - 64 - 40), style: .plain)
        contentTableView.backgroundColor = UIColor.red
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "contentTableView")
        contentSV.addSubview(contentTableView)
        
        for i in 0..<dataArray.count {
            let x: CGFloat = CGFloat(i * 100)
            let lab = createLab(x: x, y: 10, width: 100, title: dataArray[i]["title"]!)
            contentSV.addSubview(lab)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == titleTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleTableView", for: indexPath) 
            cell.selectionStyle = .none
            cell.textLabel?.text = dataArray[indexPath.row]["routeName"]!
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            if indexPath.row % 2 == 1 {
                cell.backgroundColor = grayColor
            } else {
                cell.backgroundColor = UIColor.white
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentTableView", for: indexPath) 
        cell.selectionStyle = .none
            
        for i in 0..<dataArray.count {
            let x: CGFloat = CGFloat(i * 100)
            
            var title = dataArray[i]["time"]!
            switch i {
            case 0:
                title = dataArray[i]["time"]!
            case 1:
                title = dataArray[i]["num"]!
            case 2:
                title = dataArray[i]["price"]!
            case 3:
                title = dataArray[i]["code"]!
            default: break
                
            }
            
            let lab = createLab(x: x, y: 10, width: 100, title: title)
            cell.contentView.addSubview(lab)
            
            
        }
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = grayColor
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == titleTableView {
            contentTableView.setContentOffset(CGPoint(x: contentTableView.contentOffset.x, y: titleTableView.contentOffset.y), animated: true)
        }
        
        if scrollView == contentTableView {
            titleTableView.setContentOffset(CGPoint(x: 0, y: contentTableView.contentOffset.y), animated: true)
        }
    }
    
    //创建label 
    
    func createLab(x: CGFloat, y: CGFloat, width: CGFloat, title: String) -> UILabel {
        let label = UILabel.init(frame: OCCGRect(x, y, width, 40))
        label.text = title
        label.textAlignment = .center
        return label
    }
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
