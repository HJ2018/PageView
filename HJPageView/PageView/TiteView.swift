//
//  TiteView.swift
//  HJPageView
//
//  Created by Prince on 2017/6/12.
//  Copyright © 2017年 Prince. All rights reserved.
//

import UIKit


protocol HJTitleViewDelegate : class {
    
    func titleView(_ PageView : TiteView , targetIndex : Int)
}

class TiteView: UIView {
    
    weak var delegate : HJTitleViewDelegate?
    
    fileprivate var titles : [String]
    
    fileprivate var style :TitleStyle
    
    fileprivate lazy var currentIndex : Int = 0
    
    fileprivate lazy var titleLables : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollview : UIScrollView = {
        
        let scrollview = UIScrollView(frame: self.bounds)
        
        scrollview.showsHorizontalScrollIndicator = false
        
        scrollview.scrollsToTop = false
        
        return scrollview
        
    }()
    
    init(frame: CGRect , titles : [String], style : TitleStyle) {
        
        
        self.titles = titles
        
        self.style = style
        
        super.init(frame: frame)
        
        setupUI()
        
    } 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TiteView{
    
    fileprivate func setupUI(){
        
        
        addSubview(scrollview)
        
        setTitleUpLables()
        
        setTitleLableFrame()
    }
    
    
    private func setTitleUpLables(){
        
        for(i, title) in titles.enumerated(){
            
            let titleLable = UILabel()
            
            titleLable.text = title
            
            titleLable.textColor = style.normalColor
            
            titleLable.font = UIFont.systemFont(ofSize: style.fontSize)
            
            titleLable.tag = i
            
            titleLable.textAlignment = .center
            
            titleLable.textColor = i == 0 ? style.selectColor : style.normalColor
            
            scrollview .addSubview(titleLable)
            
            titleLables.append(titleLable)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLableClick(_: )))
            
            titleLable.addGestureRecognizer(tapGes)
            
            titleLable.isUserInteractionEnabled = true
            
        }
    }
    
    private func setTitleLableFrame(){
        
        let count = titles.count
        
        for (i , lable) in titleLables.enumerated() {
            
            var w : CGFloat = 0
            
            let h : CGFloat = bounds.height
            
            var x : CGFloat = 0
            
            let y : CGFloat = 0
            
            if style.isScrollEnable {
                
               w = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : lable.font], context: nil).width

                if i == 0 {
                    
                    x = style.itemMargin * 0.5
                }else{
                    
                    let PreLable = titleLables[i - 1]
                    
                    x = PreLable.frame.maxX + style.itemMargin
                }
            }else{
                
                w = bounds.width / CGFloat(count)
                
                x = w * CGFloat(i)
                
            }
            
            lable.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollview.contentSize = style.isScrollEnable ? CGSize(width: titleLables.last!.frame.maxX + style.itemMargin * 0.5, height: 0) : CGSize.zero
    }
}

extension TiteView{
    
    @objc fileprivate func titleLableClick(_ tapGes : UITapGestureRecognizer){
        
        let  newLable  = tapGes.view as! UILabel
        
        let sourceLable = titleLables[currentIndex]
        
        newLable.textColor = style.selectColor
        
        sourceLable.textColor = style.normalColor
        
        currentIndex = newLable.tag
        
        
        delegate?.titleView(self, targetIndex: currentIndex)
        
        if style.isScrollEnable{
            
            var  offset  = newLable.center.x - scrollview.bounds.width * 0.5
            
            if offset < 0 {
                
                offset = 0
            }
            if offset > (scrollview.contentSize.width - scrollview.bounds.width) {
                
                offset = scrollview.contentSize.width - scrollview.bounds.width
            }
            
            scrollview.setContentOffset(CGPoint(x : offset , y : 0), animated: true)
            
        }
    }
    
    private func adjustTitleLable(targetIndex : Int){
        
    }
}


extension TiteView : HJContentViewDelegate {
    
    func contenView(_ contenView: ContenView, targetIndex: Int) {
        
        let newLable = titleLables[targetIndex]
        
        let sourceLable = titleLables[currentIndex]
        
        
        newLable.textColor = style.selectColor
        
        sourceLable.textColor = style.normalColor
        
        currentIndex = targetIndex
        
        if style.isScrollEnable{
            
            var  offset  = newLable.center.x - scrollview.bounds.width * 0.5
            
            if offset < 0 {
                
                offset = 0
            }
            if offset > (scrollview.contentSize.width - scrollview.bounds.width) {
                
                offset = scrollview.contentSize.width - scrollview.bounds.width
            }
            
            scrollview.setContentOffset(CGPoint(x : offset , y : 0), animated: true)
            
        }
    }
}










