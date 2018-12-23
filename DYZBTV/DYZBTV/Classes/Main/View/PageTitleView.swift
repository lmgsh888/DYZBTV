//
//  PageTitleView.swift
//  DYZBTV
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 mac. All rights reserved.
//  菜单栏

import UIKit

//MARK: - 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView,selectedIndex : Int)
}

//MARK: - 定义常量
private var currentIndex : Int = 0
//滑块的高度
private let kScrollViewLineH : CGFloat = 2
//底线的高度
private let kBottomLineH : CGFloat = 0.5
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
class PageTitleView: UIView {

    //MARK: - 定义属性
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    
    //MARK: - 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    //title中的scroView
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    //滑块
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
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
        //1.给添加UIScrollow
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.设置标题对应的label
        setTitleLabel()
        
        //3.设置底线和滑块
        setBottomLineAndScrollLine()
    }
    
    //设置Title对应的lable
    fileprivate func setTitleLabel(){
        
        let labelY : CGFloat = 0;
        let labelW : CGFloat = frame.width / CGFloat (titles.count)
        let labelH : CGFloat = frame.height - kScrollViewLineH;
        
        for (index,title) in titles.enumerated() {
            //1.创建Label
            let label = UILabel()
            
            //2.设置title的属性
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15.0)
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
    
    //添加底部线条和滑块
    fileprivate func setBottomLineAndScrollLine(){
        
        //1.设置底线
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y:self.bounds.height - kBottomLineH , width: self.bounds.width, height: kBottomLineH)
        lineView.backgroundColor = UIColor.lightGray
        addSubview(lineView)
        
        //2.添加滑块
        //获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        addSubview(scrollLine)
        
        let lineX = firstLabel.frame.origin.x
        let lineY = bounds.height - kScrollViewLineH
        let lineW = firstLabel.frame.width
        let lineH = kScrollViewLineH
        scrollLine.frame = CGRect(x: lineX, y: lineY, width: lineW, height: lineH)
        firstLabel.textColor = UIColor.orange
    }
}

//MARK: - 事件
extension PageTitleView{
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        //1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //2.如果是同一个title直接返回
        if currentLabel.tag == currentIndex { return }
        //3.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        //4.切换颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //5.保存最近Lable的下标值
        currentIndex = currentLabel.tag
        
        //6.滚动条位置发生变化
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //7.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
        
    }
}

extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat,sourceIndex : Int,targetIndex : Int){
        
        //1.取出sourceIndex 、targetIndex对应的titleLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.计算滑块的位移
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.处理title文字颜色渐变
        //3.1 颜色渐变的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        //3.1 sourceTitleColor
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.2 targetTitleColor
        targetLabel.textColor = UIColor(r: kNormalColor.0 - colorDelta.0 * progress, g: kNormalColor.1 - colorDelta.1 * progress, b: kNormalColor.2 - colorDelta.2 * progress)
        
        //保存最新的index
        currentIndex = targetIndex
    }
}














