//
//  WaterFallFlowLayout.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/17.
//  Copyright © 2017年 余意. All rights reserved. ELWaterFallLayout
//

import UIKit

protocol WaterFallFlowLayoutDelegate : NSObjectProtocol {
    func returnFlowLayoutHeight(_ flowLayout: WaterFallFlowLayout, heightForRowAt index: Int) -> CGFloat;
}

class WaterFallFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate var attrArr: [UICollectionViewLayoutAttributes] = []
    
    fileprivate var lineHeightRecArr: [CGFloat] = [0]
    
    fileprivate var lineWidth: CGFloat = 0
    
    weak open var delegate: WaterFallFlowLayoutDelegate?
    
    open var lineCount: Int = 3 {
        didSet {
            self.resetLineHeight()
            self.restLineWidth()
            self.invalidateLayout()
        }
    }
    
    open var hItemSpace: CGFloat = 10 {
        didSet {
            self.resetLineHeight()
            self.restLineWidth()
            self.invalidateLayout()
        }
    }
    
    open var vItemSpace: CGFloat = 10 {
        didSet {
            self.resetLineHeight()
            self.restLineWidth()
            self.invalidateLayout()
        }
    }
    
    open var edge: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.resetLineHeight()
            self.restLineWidth()
            self.invalidateLayout()
        }
    }
    
    override public init() {
        super.init()
        guard let lineWidth = self.collectionView?.frame.size.width else {
            return
        }
        self.lineWidth = lineWidth
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetLineHeight() {
        lineHeightRecArr.removeAll()
        for _ in 0..<lineCount {
            lineHeightRecArr.append(0.0)
        }
    }
    
    func restLineWidth() {
        switch self.scrollDirection {
        case .vertical:
            self.lineWidth = ((self.collectionView?.frame.size.width)! - self.edge.left - self.edge.right - CGFloat(self.lineCount - 1) * self.hItemSpace) / CGFloat(self.lineCount);
        default:
            self.lineWidth = ((self.collectionView?.frame.size.height)! - self.edge.top - self.edge.bottom - CGFloat(self.lineCount - 1) * self.vItemSpace) / CGFloat(self.lineCount);
        }
    }
    
    override open func prepare() {
        super.prepare()
        restLineWidth()
        resetLineHeight()
        
        if let sectionCount = self.collectionView?.dataSource?.numberOfSections!(in: self.collectionView!) {
            for section in 0..<sectionCount {
                if let rowCount = self.collectionView?.dataSource?.collectionView(self.collectionView!, numberOfItemsInSection: section) {
                    for row in 0..<rowCount {
                        let attr = UICollectionViewLayoutAttributes(forCellWith:IndexPath(item:row,section:section))
                        self.modifyLayoutAttributes(attr: attr)
                        attrArr.append(attr)
                    }
                }
            }
        }
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attrArr[indexPath.item]
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrArr
    }
    
    func modifyLayoutAttributes(attr: UICollectionViewLayoutAttributes?) {
        if let a = attr {
            switch self.scrollDirection {
            case .vertical:
                let mostTuple = self.findShortestLine()
                let x = CGFloat(mostTuple.index) * (self.lineWidth + self.hItemSpace) + self.edge.left
                let y = mostTuple.height + self.vItemSpace
                let width = self.lineWidth
                
                let height = self.delegate?.returnFlowLayoutHeight(self, heightForRowAt: a.indexPath.row)
                
                a.frame = CGRect(x: x, y: y, width: width, height: height!)
                self.updateLineHeightRec(at: mostTuple.index, with: y + height!)
                
            case .horizontal:
                let mostTuple = self.findShortestLine()
                let y = CGFloat(mostTuple.index) * (self.lineWidth + self.vItemSpace) + self.edge.top
                let x = mostTuple.height + self.hItemSpace
                let height = self.lineWidth
                
                let width = self.delegate?.returnFlowLayoutHeight(self, heightForRowAt: a.indexPath.row)
                
                a.frame = CGRect(x: x, y: y, width: width!, height: height)
                
                self.updateLineHeightRec(at: mostTuple.index, with: x + width!)
            default:
                dPrint(item: "Unkown scroll direction")
            }
        }
    }
    
    func findShortestLine() -> (index: Int, height: CGFloat) {
        var shortestHeight = CGFloat.greatestFiniteMagnitude
        var shortestIndex = 0
        for index in 0..<self.lineHeightRecArr.count {
            if shortestHeight > self.lineHeightRecArr[index] {
                shortestHeight = self.lineHeightRecArr[index]
                shortestIndex = index
            }
        }
        return (shortestIndex,shortestHeight)
    }
    
    func findlongestLine() -> (index: Int, height: CGFloat) {
        var longestHeight: CGFloat = 0.0
        var longestIndex = 0
        for index in 0..<self.lineHeightRecArr.count {
            if longestHeight < self.lineHeightRecArr[index] {
                if longestHeight < self.lineHeightRecArr[index] {
                    longestHeight = self.lineHeightRecArr[index]
                    longestIndex = index
                }
            }
        }
        return (longestIndex,longestHeight)
    }
    
    func updateLineHeightRec(at index: Int, with height: CGFloat) {
        self.lineHeightRecArr[index] = height
    }
    
    override open var collectionViewContentSize: CGSize {
        get {
            switch self.scrollDirection {
            case .vertical:
                return CGSize(width: (self.collectionView?.frame.size.width)!, height: self.findlongestLine().height)
            default:
                return CGSize(width: self.findlongestLine().height, height: (self.collectionView?.frame.size.height)!)
            }
        }
    }

}







































