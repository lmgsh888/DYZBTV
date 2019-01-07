//
//  CollectionCycleCell.swift
//  DYZBTV
//
//  Created by mac on 2019/1/6.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let imageUrl = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with:imageUrl, placeholder:UIImage(named: "Img_default"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
