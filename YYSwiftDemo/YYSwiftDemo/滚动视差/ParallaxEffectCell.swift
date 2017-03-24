//
//  ParallaxEffectCell.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/23.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit


class ParallaxEffectCell: UITableViewCell {
    
    var parallaxSize: CGFloat = 100
    var parallaxViews = [UIView]()
    
    var backIV: UIImageView!
    var gradeView: UIView!
    var lineView: UIView!
    var titleLabel: UILabel!
    
    private var separateHeight: CGFloat = 2

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.backIV.frame = CGRect(x: 0, y:self.backIV.frame.origin.y, width: self.bounds.width, height: self.bounds.height + self.parallaxSize)
        
        self.lineView.frame = CGRect(x: 0, y: self.frame.height - self.separateHeight, width: self.frame.width, height: self.separateHeight)
        
        UIView.animate(withDuration: 0.3) { 
            self.gradeView.frame = self.bounds
        }
    }
    
    func setup() {
        self.selectionStyle = .none
        layer.masksToBounds = true
        
        backIV = UIImageView.init()
        backIV.contentMode = .scaleAspectFill
        self.parallaxViews.append(backIV)
        self.contentView.addSubview(backIV)
        
        gradeView = UIView.init()
        gradeView.backgroundColor = UIColor.black
        gradeView.isUserInteractionEnabled = false
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(gradeView)
        
        lineView = UIView.init()
        lineView.backgroundColor = UIColor.black
        self.contentView.addSubview(lineView)
        
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
        self.contentView.addSubview(titleLabel)
        
    }
    
    func parallaxOffset(_ tableView: UITableView) {
        //place in parallax-position
        var deltaY = (frame.origin.y + frame.height/2) - tableView.contentOffset.y
        deltaY = min(tableView.bounds.height, max(deltaY, 0))
        var move : CGFloat = (deltaY / tableView.bounds.height) * self.parallaxSize
        move = move / 2.0  - move
        for view in self.parallaxViews {
            view.frame.origin.y = move
        }
    }
}



















