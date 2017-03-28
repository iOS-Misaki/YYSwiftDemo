//
//  DragCell.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/28.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class DragCell: UICollectionViewCell {
    
    var label: UILabel!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.center = self.contentView.center
        label.textAlignment = .center
        self.contentView.addSubview(label)
        
        self.contentView.backgroundColor = UIColor.white
    }
}
