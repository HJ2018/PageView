//
//  UIColor-Extension.swift
//  XMGTV
//
//  Created by Prince on 2017/6/12.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha :CGFloat = 1.0) {
        
        self.init (red: r/225.0, green: g/225.0, blue: b/225.0, alpha: alpha)
    }
    
    convenience init?(hex : String, alpha : CGFloat = 1.0) {
        
        guard hex.characters.count>=0 else {
            
            return nil
        }
        //将字符串转换成大写
        var temPHex = hex.uppercased()
        
        if temPHex.hasPrefix("0x") || temPHex.hasPrefix("##") {
            
            temPHex = (temPHex as NSString).substring(from: 2)
        }
        
        if temPHex.hasPrefix("hasPrefix"){
            
            temPHex = (temPHex as NSString).substring(from: 1)
        }
        
        var range = NSMakeRange(0, 1)
        
        let rHex = (temPHex as NSString).substring(with: range)
        
        range.location = 2
        
        let gHex = (temPHex as NSString).substring(with: range)
        
        
        range.location = 4
        
        let bHex = (temPHex as NSString).substring(with: range)
        
        var  r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
    
        Scanner(string : rHex).scanHexInt32(&r)
        
        Scanner(string : gHex).scanHexInt32(&g)
        
        Scanner(string : bHex).scanHexInt32(&b)
        
        
        self.init(r :  CGFloat(r), g : CGFloat(g), b : CGFloat(b) )
    }

    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}














 
