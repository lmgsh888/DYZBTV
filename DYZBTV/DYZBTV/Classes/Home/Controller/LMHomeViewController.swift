//
//  LMHomeViewController.swift
//  DYZB2018
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class LMHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blue
        //设置的导航栏
        setNavigatorBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LMHomeViewController{
    fileprivate func setNavigatorBar(){
        //1.左边
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", self,#selector(self.logoClick))
        //2.右边
        //历史
        let size = CGSize(width: 40, height: 40)
        let historyBarBtn = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click",size:size,self,#selector(self.historyClick))
        //搜索
        let searchBarBtn = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click",size:size,self,#selector(self.searchClick))
        //二维码
        let scanBarBtn = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click",size:size,self,#selector(self.scanClick))
        //右边
        navigationItem.rightBarButtonItems = [historyBarBtn,searchBarBtn,scanBarBtn]

    }
}

//导航栏菜单栏项的事件
extension LMHomeViewController{
    
    //logo点击事件
    @objc fileprivate func logoClick(){
        
        print("logoClick")
    }
    
    //历史点击事件
    @objc fileprivate func historyClick(){
         print("historyClick")
    }
    //搜索事件
    @objc fileprivate func searchClick(){
        print("searchClick")
    }
    
    //二维码事件
    @objc fileprivate func scanClick(){
        print("scanClick")
    }
    
    
}


