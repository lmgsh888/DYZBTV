//
//  PageContentView.swift
//  DYZBTV
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

//MARK: - 定义代理
protocol PageContentViewDelegate : class {
    func pageContentView(_ pageContentView : PageContentView,progress : CGFloat,soureIndex : Int,targetIndex : Int)
}


//MARK: - 定义属性
private let collectionViewID = "collectionViewID"
class PageContentView: UIView {

    //MARK: - 定义属性
    fileprivate var childVcs : [UIViewController]
    //使用weak防止强引用
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    //MARK: - 懒加载
    fileprivate lazy var collectionView : UICollectionView  = {[weak self] in
        
        //1.创建流水布局
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize =  (self?.bounds.size)!
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
      
        //2.创建collectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: flowLayout)
        //2.1 设置属性
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //2.2 注册collectionView
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewID)
      
        
        return collectionView
    }()
    
    init(frame: CGRect,childVcs : [UIViewController],parentViewController : UIViewController?) {
     
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
       //设置UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - 设置UI
extension PageContentView{
    
    fileprivate func setUpUI(){
        //1.将所有的子控制器添加到父控制上
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - 实现数据源代理方法
extension PageContentView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.从缓存中取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath)
        //2.取出子控制器
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        //3.给子控制器设置frame
        childVc.view.frame = cell.contentView.bounds
        //4.将子控制器的view添加到contentView
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK: - 实现代理UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        startOffsetX = scrollView.contentOffset.x
        print("startOffsetX--%@",startOffsetX)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.定义需要的值
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.获取当前的滑动偏移量
        let currentOffsetX = scrollView.contentOffset.x
        
        //3.判断滑动的方向
        let scrollViewW = scrollView.bounds.width
      
        if(currentOffsetX > startOffsetX){ //左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if(targetIndex >= childVcs.count){
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{ //右滑
            progress = 1 - ( currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if(sourceIndex >= childVcs.count){
                sourceIndex = childVcs.count - 1
            }
        }
        
        //通知代理
        delegate?.pageContentView(self, progress: progress, soureIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}


extension PageContentView{
    func setContentIndex(_ currentIndex : Int   ){
        
        //滚动位置
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}


