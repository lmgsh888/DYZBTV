//
//  RecommendCycleView.swift
//  DYZBTV
//
//  Created by mac on 2018/12/16.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class RecommendCycleView: UIView {

//    class func recommendCycleView() ->
//        RecommendCycleView {
//        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
//    }

}

extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

