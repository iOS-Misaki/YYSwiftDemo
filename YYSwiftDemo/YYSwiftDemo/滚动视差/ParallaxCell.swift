//
//  ParallaxCell.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/4/13.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class ParallaxCell: UITableViewCell {
    
    var parallaxSize: CGFloat = 100
    
    var bgView: UIImageView!
    var shadowView: UIView!
    var separatorView: UIView!
    
    private var separateHeight: CGFloat = 2

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubView()
    }

    
    func initSubView() {
        self.selectionStyle = .none
        layer.masksToBounds = true
        
        bgView = UIImageView.init()
        bgView.contentMode = .scaleAspectFill
        self.addSubview(bgView)
        
        shadowView = UIView.init()
        shadowView.backgroundColor = UIColor.black
        shadowView.isUserInteractionEnabled = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shadowView)
        
        separatorView = UIView.init()
        separatorView.backgroundColor = UIColor.black
        self.addSubview(separatorView)
    }
    
    func parallaxOffset(tableView: UITableView) {
        var deltaY = (frame.origin.y + frame.height / 2 ) - tableView.contentOffset.y
        deltaY = min(tableView.bounds.height, max(deltaY, 0))
        var move: CGFloat = (deltaY / tableView.bounds.height) * self.parallaxSize
        move = move / 2 - move
        bgView.frame.origin.y = move
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgView.frame = CGRect(x: 0, y: self.bgView.frame.origin.y, width: self.bounds.width, height:self.bounds.height + self.parallaxSize)
        
        self.separatorView.frame = CGRect(x: 0, y: self.frame.height - self.separateHeight, width: self.frame.width, height: self.separateHeight)
        
        UIView.animate(withDuration: 0.3) { 
            self.shadowView.frame = self.bounds
        }
    }
}
