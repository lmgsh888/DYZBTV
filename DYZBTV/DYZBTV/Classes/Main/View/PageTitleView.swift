//
//  PageTitleView.swift
//  DYZBTV
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 mac. All rights reserved.
//  菜单栏

import UIKit

//MARK: - 定义常量
private let kScrollViewLineH : CGFloat = 2
class PageTitleView: UIView {

    //MARK: - 定义属性
    fileprivate var titles : [String]
    
    
    //MARK: - 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK: - 初始化
    init(frame: CGRect,titles : [String]) {
        
        self.titles = titles;
        super.init(frame: frame)
        
        //设置UI
        setUpUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI
extension PageTitleView {
    
    //设置UI
    fileprivate func setUpUI(){
        //给添加UIScrollow
        addSubview(scrollView)
        scrollView.frame = bounds
        //设置标题对应的label
        setTitleLabel()
    }
    
    //设置Title对应的lable
    private func setTitleLabel(){
        
        let labelY : CGFloat = 0;
        let labelW : CGFloat = frame.width / CGFloat (titles.count)
        let labelH : CGFloat = frame.height - kScrollViewLineH;
        
        for (index,title) in titles.enumerated() {
            //1.创建Label
            let label = UILabel()
            
            //2.设置title的属性
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12.0)
            label.tag = index
            
            //3.设置frame
            let labelX : CGFloat = CGFloat(index) * labelW;
          
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView
            scrollView.addSubview(label)
            
            //5.将label添加到数组
            titleLabels.append(label)
            
            //6.添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
}

extension PageTitleView{
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        print("titleLabelClick")
    }
}




