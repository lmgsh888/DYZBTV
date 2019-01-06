//
//  CollectionHeaderView.swift
//  DYZBTV
//
//  Created by mac on 2018/12/16.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup?{
        didSet{
            tagNameLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}


