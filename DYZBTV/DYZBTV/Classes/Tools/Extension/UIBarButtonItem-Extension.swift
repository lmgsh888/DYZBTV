//
//  UIBarButtonItem-Extension.swift
//  DYZBTV
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String,highImageName : String = "",size : CGSize = CGSize.zero,_ target: AnyObject? = nil , _ action: Selector) {
        //1.创建按钮
        let btn = UIButton()
        //2.设置图片
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named:highImageName), for: .highlighted)
        }
        
        //3.设置尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
   
        //4.设置事件
        btn.addTarget(target, action: action, for: .touchUpInside)
        //5.创建UIBarButtonItem
        self.init(customView:btn)
    }
}
