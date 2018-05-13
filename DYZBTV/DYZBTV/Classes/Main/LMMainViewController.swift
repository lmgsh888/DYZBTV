//
//  LMMainViewController.swift
//  DYZB2018
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class LMMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //主页
        addChildVcWithStoryBoard(name: "Home")
        //直播
        addChildVcWithStoryBoard(name: "Live")
        //关注
        addChildVcWithStoryBoard(name: "Follow")
        //我的
        addChildVcWithStoryBoard(name: "Profile")
    }

}

//加载storyBoard控制器
extension LMMainViewController{
    
    
    fileprivate func addChildVcWithStoryBoard(name : String){
        //1.加载storyBoard中的子控制器
        let childVc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!;
        
        //2.将控制器加载到TabBarController
        addChildViewController(childVc);
        
    }
}



