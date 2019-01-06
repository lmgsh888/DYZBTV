//
//  RecommendViewController.swift
//  DYZBTV
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

private let kHeaderViewH : CGFloat = 50
private let kHeaderViewID = "kHeaderViewID"
private let kNormalViewID = "kNormalViewID"
private let kPrettyViewID = "kPrettyViewID"

private let kItemW = (KScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3

private let kcycleViewH : CGFloat =  KScreenW * 3 / 8

class RecommendViewController: UIViewController {

    //MARK: - 懒加载
    lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    lazy var collectionView : UICollectionView = {
        
        //1.创建流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 10 //行间距
        layout.minimumInteritemSpacing = kItemMargin //列间距
        //头部视图的尺寸
        layout.headerReferenceSize = CGSize(width: KScreenW, height: kHeaderViewH)
        //设置组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left:kItemMargin, bottom: 0, right: kItemMargin)
       

        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
         //设置自动伸缩
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        //注册cell
        collectionView.register((UINib(nibName: "CollectionNormalCell", bundle: nil)), forCellWithReuseIdentifier: kNormalViewID)
        collectionView.register((UINib(nibName: "CollectionPrettyCell", bundle: nil)), forCellWithReuseIdentifier:kPrettyViewID)
        //注册头部
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
       

        return collectionView
        
    }()
    
    //顶部无限轮播
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kcycleViewH, width: KScreenW, height: kcycleViewH)
        cycleView.backgroundColor = UIColor.red
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.添加无限轮播
        collectionView.addSubview(recommendCycleView)
        //2.添加collectionView
        view.addSubview(collectionView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kcycleViewH, left: 0, bottom: 0, right: 0)
        
        //请求数据
        recommendVM.requestData(){
            //刷新界面
            self.collectionView.reloadData()
        }
        
    }
    
}

extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   //返回组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
//        print("numberOfSections---",recommendVM.anchorGroups.count)
        
        return recommendVM.anchorGroups.count
    }
    
    //返回每组的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("numberOfItemsInSection = ",recommendVM.anchorGroups[section].anchors.count)
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    //返回具体的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.取出数据
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //2.定义cell
        var cell : CollectionViewBaseCell!
    
        if(indexPath.section == 1){
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyViewID, for: indexPath) as! CollectionPrettyCell
          
        }else{
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalViewID, for: indexPath) as! CollectionNormalCell
        }
        
        //3.设置模型数据
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出view
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.section == 1){
            return CGSize(width:kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

//MARK: - 请求数据
extension RecommendViewController{
    
}






