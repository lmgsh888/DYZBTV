//
//  RecommendCycleView.swift
//  DYZBTV
//
//  Created by mac on 2019/1/6.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - 定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //1.刷新表格
            collectionView.reloadData()
            
            //2.设置页数
            pageControl.numberOfPages = self.cycleModels?.count ?? 0
            
            //3.让轮播图默认滚动到中间位置
            collectionView.scrollToItem(at:IndexPath(item: (self.cycleModels?.count ?? 0) * 10, section: 0), at: .left, animated: true)
            
            //4.设置定时器
            removerCycleTimer()
            addCycleTimer()
            
            
        }
    }
    
    override func awakeFromNib() {
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //设置size要在此方法中设置不然不准确
        layout.itemSize = collectionView.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
    }
    
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK: - 数据源方法
extension RecommendCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        //2.给模型赋值
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).row % cycleModels!.count]

        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.获取偏移量
        let offSetx = scrollView.contentOffset.x + collectionView.bounds.width * 0.5
        
        //2.设置pageControl页
        pageControl.currentPage = Int(offSetx / collectionView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removerCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK: - 定时器
extension RecommendCycleView {
    func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        //将定时器放入主循环中
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    func removerCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    func scrollToNext(){
        //1、获取当前collectionView的偏移量
        let currentOffSetX = collectionView.contentOffset.x
        
        //2、设置滚动的偏移量
        let nextOffSetX =  currentOffSetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: nextOffSetX, y: 0), animated: true)
    }
}








