//
//  NSDate-extension.swift
//  DYZBTV
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation

extension Date{
 
    static func getCurrentTime() -> String{
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}








