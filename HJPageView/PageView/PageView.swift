//
//  PageView.swift
//  HJPageView
//
//  Created by Prince on 2017/6/12.
//  Copyright © 2017年 Prince. All rights reserved.
//

import UIKit

class PageView: UIView {
    
    fileprivate var titles : [String]
    
    fileprivate var childVcs : [UIViewController]
    
    fileprivate var parentVc : UIViewController
    
    fileprivate var style : TitleStyle
    
    fileprivate var HJtitleview : TiteView!
    
    init(frame: CGRect , titles : [String], childVcs : [UIViewController], parentVc : UIViewController , style : TitleStyle) {
        
        self.titles = titles
        
        self.childVcs = childVcs
        
        self.parentVc = parentVc
        
        self.style = style;
        
        super.init(frame : frame)
        
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: -设置界面

extension PageView{
    
    fileprivate func setUpUI() {
        
        setUpTitle()
        
        setUpCenteView()
        
    }
    
    private func setUpTitle(){
        
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeighe)
        
        HJtitleview = TiteView(frame: titleFrame, titles: titles, style : style)
        
        HJtitleview.backgroundColor = UIColor.randomColor()
        
        addSubview(HJtitleview!)
    }
    
    private func setUpCenteView(){
        
        
        let conteViewFrame = CGRect(x: 0, y: HJtitleview.frame.maxY, width: bounds.width, height: bounds.height - HJtitleview.frame.height)
        
        
        let conteView = ContenView(frame: conteViewFrame, childVcs: childVcs, parentVc: parentVc)
        
        conteView.backgroundColor = UIColor.randomColor()
        
        addSubview(conteView)
        
        HJtitleview.delegate = conteView
        
        conteView.delegate = HJtitleview
    }
}








