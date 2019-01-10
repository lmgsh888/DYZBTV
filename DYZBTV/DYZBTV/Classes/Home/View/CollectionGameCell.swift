//
//  CollectionGameCell.swift
//  DYZBTV
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    //MARK: - 定义属性监听属性变化
    var groups : BaseGameModel? {
        didSet {
            
            if let iconUrl = URL(string: groups?.icon_url ?? ""){
                 iconImageView.kf.setImage(with: iconUrl)
            }else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
           
            tagNameLabel.text = groups?.tag_name
        }
    }
    

}

