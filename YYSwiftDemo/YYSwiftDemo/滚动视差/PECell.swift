//
//  PECell.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/24.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

class PECell: UITableViewCell {
    
    var parallaxView = [UIView]()
    var parallaxSize: CGFloat = 100
    
    var backgroundIV: UIImageView!
    var gradeView: UIView!
    var separeatorView: UIView!
    var titleLab: UILabel!
    
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
    
    func setup() {
        layer.masksToBounds = true
        self.selectionStyle = .none
        
        backgroundIV = UIImageView.init()
        backgroundIV.backgroundColor = randomColor()
        backgroundIV.contentMode = .scaleAspectFill
        self.parallaxView.append(backgroundIV)
        self.addSubview(backgroundIV)
        
        gradeView = UIView.init()
        gradeView.backgroundColor = UIColor.black
        gradeView.isUserInteractionEnabled = false
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gradeView)
        
        separeatorView = UIView.init()
        separeatorView.backgroundColor = UIColor.black
        self.addSubview(separeatorView)
        
        titleLab = UILabel.init()
        titleLab.textColor = UIColor.white
        titleLab.textAlignment = .center
        titleLab.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(titleLab)
    }
    
    func parallaxOffset(tableView: UITableView) {
        var deltaY = (frame.origin.y + frame.height / 2) - tableView.contentOffset.y
        deltaY = min(tableView.bounds.height, max(deltaY, 0))
        var move: CGFloat = (deltaY / tableView.bounds.height) * self.parallaxSize
        move = move / 2.0 - move
        for view in self.parallaxView {
            view.frame.origin.y = move
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundIV.frame = CGRect(x: 0, y: self.backgroundIV.frame.origin.y, width: self.bounds.width, height:self.bounds.height + self.parallaxSize)
        
        self.separeatorView.frame = CGRect(x: 0, y: self.frame.height - self.separateHeight, width: self.frame.width, height: self.separateHeight)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { 
            self.gradeView.frame = self.bounds
        }, completion: nil)
    }


}
