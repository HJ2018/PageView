//
//  ViewController.swift
//  HJPageView
//
//  Created by Prince on 2017/6/12.
//  Copyright © 2017年 Prince. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        let title = ["娱乐","娱乐","娱乐乐","娱乐","娱乐乐","娱乐","娱乐乐","娱乐","娱乐","娱乐"]
        
        let style = TitleStyle();
        
//        style.normalColor = UIColor.randomColor()
        
        style.isScrollEnable = true
        var childVcs = [UIViewController]()
        
        for _ in 0..<title.count {
            let vc = UIViewController()
            
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs .append(vc)
        }
        
        let pagFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        
        let HJPage = PageView(frame: pagFrame, titles: title, childVcs: childVcs, parentVc: self, style : style)
        
        view .addSubview(HJPage)
        
    }

}

