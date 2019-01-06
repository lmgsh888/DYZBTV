//
//  AnchorGroup.swift
//  DYZBTV
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    ///该组对应的房间信息
    var room_list : [[String : AnyObject]]?{
        didSet{
            guard let room_list = room_list else { return }
            
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    var icon_name : String = "home_header_normal"
    lazy var anchors : [AnchorModel] = [AnchorModel]()
}





