//
//  ParallaxViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/4/13.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class ParallaxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    
    private var cellHeight: CGFloat = 120
    private var selectedCellHeight: CGFloat = 310
    
    private let normalAlpha: CGFloat = 0.6
    private let selectedAlpha: CGFloat = 0.1
    
    private var selectedCellIndex: IndexPath = IndexPath.init()
    
    lazy var parallaxTableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ParallaxCell.classForCoder() , forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.parallaxTableView.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParallaxCell
        cell.parallaxSize = 150
        cell.shadowView.alpha = self.normalAlpha
        cell.bgView.image = UIImage(named:"bg-\(indexPath.row % 6 + 1)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndex == indexPath {
            return self.selectedCellHeight
        }
        
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var unfoldFlag: Bool = false
        
        if (selectedCellIndex == indexPath) {
            selectedCellIndex = IndexPath.init()
            unfoldFlag = false
        } else {
            selectedCellIndex = indexPath
            unfoldFlag = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        for cell in tableView.visibleCells {
            let pCell = cell as! ParallaxCell
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
                pCell.parallaxOffset(tableView: tableView)
                pCell.shadowView.alpha = self.normalAlpha
                pCell.layoutIfNeeded()
            }, completion: nil)
        }
        
        if unfoldFlag {
            let cell = tableView.cellForRow(at: indexPath) as! ParallaxCell
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
                cell.shadowView.alpha = self.selectedAlpha
                cell.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        for cell in parallaxTableView.visibleCells {
            let pCell = cell as! ParallaxCell
            pCell.parallaxOffset(tableView: parallaxTableView)
        }
        
    }

}
