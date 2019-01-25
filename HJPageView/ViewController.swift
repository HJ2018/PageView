//
//  ViewController.swift
//  HJPageView
//
//  Created by Prince on 2017/6/12.
//  Copyright © 2017年 Prince. All rights reserved.
//

import UIKit


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let isPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

let isPhoneX = Bool(kScreenWidth >= 375.0 && kScreenHeight >= 812.0 && isPhone)

let kNavigationHeight = CGFloat(isPhoneX ? 88 : 64)

let kStatusBarHeight = CGFloat(isPhoneX ? 44 : 20)

let kTabBarHeight = CGFloat(isPhoneX ? (49 + 34) : 49)

let kBottomSafeHeight = CGFloat(isPhoneX ? 34 : 0)

let kTopSafeHeight = CGFloat(isPhoneX ? 44 : 0)


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
        
        let pagFrame = CGRect(x: 0, y: kNavigationHeight, width: view.bounds.width, height: view.bounds.height - 64)
        
        
        let HJPage = PageView(frame: pagFrame, titles: title, childVcs: childVcs, parentVc: self, style : style)
        
        view .addSubview(HJPage)
        
    }

}

