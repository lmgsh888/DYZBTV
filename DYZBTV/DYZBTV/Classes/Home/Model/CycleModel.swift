//
//  CycleModel.swift
//  DYZBTV
//
//  Created by mac on 2019/1/6.
//  Copyright © 2019年 mac. All rights reserved.
//  无限轮播模型


import UIKit

class CycleModel: NSObject {
    ///标题
    var title : String = ""
    ///显示图片
    var pic_url : String = ""
    
    ///主播的房间字典信息
    var room : [NSString : NSObject]? {
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room as [String : Any])
        }
    }
    
    ///主播对应的模型对象
    var anchor : AnchorModel?
    
    //自定义构造函数
    init (dict : [NSString : NSObject]){
        super.init()
        
        setValuesForKeys(dict as [String : Any])
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
