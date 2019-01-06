//
//  CollectionPrettyCell.swift
//  DYZBTV
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionViewBaseCell {

@IBOutlet weak var cityName: UILabel!
    
   override var anchor : AnchorModel? {
        didSet{
            //给父类传递模型
            super.anchor = anchor
            cityName.text = anchor?.anchor_city
        }
    
    }
    
}
