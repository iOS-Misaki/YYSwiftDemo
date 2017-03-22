//
//  WaterFallFlowLayout.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/22.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit

protocol WaterfallFlowLayoutDelegate: NSObjectProtocol {
    func getCellHeight(index: Int) -> CGFloat;
}

class WaterFallFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: WaterfallFlowLayoutDelegate?
    
    fileprivate var attrArray: [UICollectionViewLayoutAttributes] = []
    fileprivate var lineHeightRecArr: [CGFloat] = [0]
    fileprivate var lineWidth: CGFloat = 0
    
    open var lineCount: Int = 3 {
        didSet{
            self.resetLineHeight()
            self.resetLineWidth()
            self.invalidateLayout()
        }
    }
    
    open var hItemSpace: CGFloat = 10 {
        didSet{
            self.resetLineHeight()
            self.resetLineWidth()
            self.invalidateLayout()
        }
    }
    
    open var vItemSpace: CGFloat = 10 {
        didSet{
            self.resetLineHeight()
            self.resetLineWidth()
            self.invalidateLayout()
        }
    }
    
    open var edge: UIEdgeInsets = UIEdgeInsets.zero {
        didSet{
            self.resetLineHeight()
            self.resetLineWidth()
            self.invalidateLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 重写的方法
    override init() {
        super.init()
        
        guard let lineWidth = self.collectionView?.frame.size.width else {
            return
        }
        self.lineWidth = lineWidth
    }
    
    //计算indexPath下item 属性的方法
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attrArray[indexPath.item]
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrArray
    }
    
    //可滚动区域的size
    override open var collectionViewContentSize: CGSize {
        get{
            switch self.scrollDirection {
            case .vertical:
                return CGSize(width: (self.collectionView?.frame.size.width)!, height: self.getLongestLine().height)
            default:
                return CGSize(width: self.getLongestLine().height, height: (self.collectionView?.frame.size.height)!)
            }
        }
    }
    
    //布局的时候调用
    override open func prepare() {
        super.prepare()
        resetLineWidth()
        resetLineHeight()
        
        if let sectionCount = self.collectionView?.dataSource?.numberOfSections!(in: self.collectionView!) {
            for i in 0..<sectionCount {
                if let rowCount = self.collectionView?.dataSource?.collectionView(self.collectionView!, numberOfItemsInSection: i) {
                    for j in 0..<rowCount {
                        let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: j, section: i))
                        self.modifyLayoutAttributes(attr: attr)
                        attrArray.append(attr)
                    }
                }
            }
        }
    }
    
    func resetLineHeight() {
        lineHeightRecArr.removeAll()
        for _ in 0..<lineCount {
            lineHeightRecArr.append(0.0)
        }
    }
    
    func resetLineWidth() {
        switch self.scrollDirection {
        case .vertical:
            self.lineWidth = ((self.collectionView?.frame.size.width)! - self.edge.left - self.edge.right - CGFloat(self.lineCount - 1) * self.hItemSpace) / CGFloat(self.lineCount)
        default:
            self.lineWidth = ((self.collectionView?.frame.size.height)! - self.edge.top - self.edge.bottom - CGFloat(self.lineCount - 1) * self.vItemSpace) / CGFloat(self.lineCount)
        }
    }
    
    func modifyLayoutAttributes(attr: UICollectionViewLayoutAttributes?) {
        if let a = attr {
            switch self.scrollDirection {
            case .vertical:
                let tuple = self.getShortestLine()
                let x = CGFloat(tuple.index) * (self.lineWidth + self.hItemSpace) + self.edge.left
                let y = tuple.height + self.vItemSpace
                let width = self.lineWidth
                let height = self.delegate?.getCellHeight(index: a.indexPath.row)
                a.frame = CGRect(x: x, y: y, width: width, height: height!)
                
                self.updateLineHeightRec(index: tuple.index, height: y + height!)
            default:
                let tuple = self.getShortestLine()
                let x = tuple.height + self.hItemSpace
                let y = CGFloat(tuple.index) * (self.lineWidth + self.vItemSpace) + self.edge.top
                let width = self.delegate?.getCellHeight(index: a.indexPath.row)
                let height = self.lineWidth
                a.frame = CGRect(x: x, y: y, width: width!, height: height)
                
                self.updateLineHeightRec(index: tuple.index, height: x + width!)
            }
        }
    }
    
    func updateLineHeightRec(index: Int, height: CGFloat) {
        self.lineHeightRecArr[index] = height
    }
    
    func getShortestLine() -> (index: Int, height: CGFloat) {
        var shortestHeight = CGFloat.greatestFiniteMagnitude
        var shortestIndex = 0
        for i in 0..<self.lineHeightRecArr.count {
            if shortestHeight > self.lineHeightRecArr[i] {
                shortestHeight = self.lineHeightRecArr[i]
                shortestIndex = i
            }
        }
        return (shortestIndex, shortestHeight)
    }
    
    func getLongestLine() -> (index: Int, height: CGFloat) {
        var longestHeight: CGFloat = 0.0
        var longestIndex = 0
        for i in 0..<self.lineHeightRecArr.count {
            if longestHeight < self.lineHeightRecArr[i] {
                longestHeight = self.lineHeightRecArr[i]
                longestIndex = i
            }
        }
        return (longestIndex,longestHeight)
    }
}

