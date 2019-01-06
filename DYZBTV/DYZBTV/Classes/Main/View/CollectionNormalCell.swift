//
//  CollectionNormalCell.swift
//  DYZBTV
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionViewBaseCell {
    
  @IBOutlet weak var roomNameLabel: UILabel!

   override var anchor : AnchorModel?{
        
        didSet{
            super.anchor = anchor
            //房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}
