//
//  CollectionViewBaseCell.swift
//  DYZBTV
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    override func awakeFromNib() {
        onlineBtn.layer.cornerRadius = 5;
        onlineBtn.layer.masksToBounds = true
        
    }
    
    var anchor : AnchorModel? {
        didSet{
            //校验数据
            guard let anchor = anchor else { return }
            //昵称
            nickNameLabel.text = anchor.nickname
    
            //显示在线人数
            var onlineStr = ""
            if anchor.online > 10000{
                onlineStr = "\(anchor.online / 10000)万人在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            //显示图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
