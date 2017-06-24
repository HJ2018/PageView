 //
//  ContenView.swift
//  HJPageView
//
//  Created by Prince on 2017/6/12.
//  Copyright © 2017年 Prince. All rights reserved.
//

import UIKit
 
 
 
private let ContenCellID = "ContenCellID"
 
 protocol HJContentViewDelegate : class {
    
    func contenView(_ contenView : ContenView , targetIndex :Int)

 }



class ContenView: UIView {
    
    weak var delegate : HJContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    
    fileprivate var parentVc : UIViewController
    
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = self.bounds.size
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContenCellID)
        
        return collectionView
        
    }()
    
    init(frame: CGRect, childVcs : [UIViewController], parentVc : UIViewController) {
        
        
        self.childVcs = childVcs
        
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        collectionView.isPagingEnabled = true
        
        collectionView.scrollsToTop = false
        
        collectionView.bounces = false
        
        collectionView.showsHorizontalScrollIndicator = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
 
 
extension ContenView{
    fileprivate func setupUI(){
        
        for childVc in childVcs {
            
            parentVc.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
    }
}

extension ContenView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContenCellID, for: indexPath)
        
        for subView in cell.contentView.subviews {
            
            subView.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        
        childVc.view.frame = cell.contentView.bounds
        
        cell.contentView .addSubview(childVc.view)
        
        return cell
        
    }
}
 
 extension ContenView : UICollectionViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        contenEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            contenEndScroll()
        }
    }
    
    private func contenEndScroll(){
        
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        delegate?.contenView(self, targetIndex: currentIndex)
        
    }
 }
 
 extension ContenView : HJTitleViewDelegate{
    
    func titleView(_ PageView: TiteView, targetIndex: Int) {
        
        let indexPath = IndexPath(item: targetIndex, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
 }
 
 
 
 
 
 
 
 
 
 
