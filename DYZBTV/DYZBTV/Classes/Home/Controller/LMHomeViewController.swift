//
//  LMHomeViewController.swift
//  DYZB2018
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit


private let kPageTitleViewH : CGFloat = 40

class LMHomeViewController: UIViewController {
    //MARK: - 懒加载
    fileprivate lazy var pageTitleView : PageTitleView = {
        
        let pageViewFrame = CGRect(x: 0, y:kStatusBar + kNavigatorBar , width: KScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTilteView = PageTitleView(frame: pageViewFrame, titles: titles)
            return pageTilteView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentY = kStatusBar + kNavigatorBar + kPageTitleViewH
        let contentH = kScreenH - contentY - kTabBarH
        let contentFrame = CGRect(x:0, y:contentY, width:KScreenW, height: contentH)
      
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor.blue
        //设置的导航栏
        setNavigatorBar()
        //设置UI
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//option + command + 左键 === 折叠代码块
//MARK: - 设置导航栏
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

//MARK: - 导航栏菜单栏项的事件
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

//MARK: - 设置UI
extension LMHomeViewController{
    fileprivate func setUpUI(){
        //不设置UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //添加pageTitleView
        view.addSubview(pageTitleView)
        
        //添加pageContentView
        view.addSubview(pageContentView)
    }
}




