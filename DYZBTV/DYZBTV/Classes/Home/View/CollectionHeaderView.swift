//
//  CollectionHeaderView.swift
//  DYZBTV
//
//  Created by mac on 2018/12/16.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}


