//
//  ParallaxEffectViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/23.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class ParallaxEffectViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    private var cellHeight: CGFloat = 240
    private var selectedCellHeight: CGFloat = 310
    
    private let normalCellGradeAlpha: CGFloat = 0.5
    private let selectedCellGradeAlpha: CGFloat = 0.2
    
    private var selectedCellIndex: IndexPath = IndexPath.init()
    
    lazy var PETableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PECell.classForCoder() , forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PETableView.contentInset = UIEdgeInsetsMake(
            -cellHeight * 0.2,
            0, 0, 0
        );

        self.view.backgroundColor = UIColor.white
        PETableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PECell
        cell.parallaxSize = 150
        cell.gradeView.alpha = self.normalCellGradeAlpha
        if indexPath == self.selectedCellIndex {
            cell.gradeView.alpha = self.selectedCellGradeAlpha
        }
        
        cell.backgroundIV.image = UIImage.init(named:"bg-\(indexPath.row % 6 + 1)")
        cell.titleLab.text = "Misaki_\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedCellIndex {
            return self.selectedCellHeight
        }
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var needShowOpenAnimation: Bool = false
        
        if (selectedCellIndex == indexPath) {
            selectedCellIndex = IndexPath.init()
            needShowOpenAnimation = false
        } else {
            selectedCellIndex = indexPath
            needShowOpenAnimation = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        for cell in tableView.visibleCells {
            let parallaxCell = cell as! PECell
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
                parallaxCell.parallaxOffset(tableView: tableView)
                parallaxCell.gradeView.alpha = self.normalCellGradeAlpha
                parallaxCell.layoutIfNeeded()
            }, completion: nil)
        }
        
        if needShowOpenAnimation {
            
            let cell = tableView.cellForRow(at: indexPath) as! PECell
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                cell.gradeView.alpha = self.selectedCellGradeAlpha
                cell.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        PETableView.visibleCells.forEach { cell in
            let parallaxCell = cell as! PECell
            parallaxCell.parallaxOffset(tableView: self.PETableView)
        }
    }

}
