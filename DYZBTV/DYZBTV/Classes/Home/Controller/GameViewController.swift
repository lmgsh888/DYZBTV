//
//  GameViewController.swift
//  DYZBTV
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (KScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50

private let kGameCellID = "kGameCellID"
private let kHeaderCellID = "kHeaderCellID"

class GameViewController: UIViewController {
    
    //MARK: - 懒加载
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: KScreenW, height: kHeaderViewH)
        //2.创建UICollectionView视图
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
         collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        
        
        //3.注册cell
        collectionView.register(UINib(nibName:"CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //4.注册headerCell
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderCellID)
        
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置UI
        setupUI()
        
        //2.加载数据
        loadData()
    }
}


//MARK: - 设置ui
extension GameViewController {
    fileprivate func setupUI(){
        
        self.view.addSubview(collectionView)
    }
}

//MARK: - 加载数据
extension GameViewController {
    fileprivate func loadData(){
        gameVM.requestAllGameData {
            self.collectionView.reloadData()
        }
    }
}


//MARK: - 实现UICollectionViewDataSource数据源方法
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.groups = self.gameVM.games[indexPath.item]
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:kHeaderCellID , for: indexPath) as! CollectionHeaderView
        headerView.tagNameLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}







