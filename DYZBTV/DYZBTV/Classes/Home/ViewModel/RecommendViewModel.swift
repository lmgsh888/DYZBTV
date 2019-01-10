//
//  RecommendViewModel.swift
//  DYZBTV
//
//  Created by mac on 2018/12/23.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Alamofire


class RecommendViewModel {
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var perrtyGroup : AnchorGroup = AnchorGroup()
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    
    
}

extension RecommendViewModel{
    
    func requestData(_ finistedCallBack :@escaping ()->()){
        
        //1.定义参数
        let parameters = ["limit" : "4", "offset" : "0","time" : Date.getCurrentTime()];
        //2.创建Group
    
        
        let dGroup = DispatchGroup()
        
        //3.请求数据
        dGroup.enter()
        //3.1 请求推荐数据
        NetWorkTool.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", .get, parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            //1.将reslut转换为字典
            guard let resultDict = result as? [String : AnyObject] else { return }
            
            //2.根据data该key,获取数组
            guard let resultArray = resultDict["data"] as? [[String : AnyObject]] else { return }
            
            //3.遍历数组将其转化成模型
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //获取主播数据
            for dict in resultArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        //3.2 请求颜值数据
        dGroup.enter()
        NetWorkTool.requestData(urlString:"http://capi.douyucdn.cn/api/v1/getVerticalRoom", .get, parameters: parameters) { (result) in
            
            //将result 转换成字典
            guard let resultDict = result as? [String : AnyObject] else { return }
            
            //2.根据data该key,获取数组
            guard let dataArray  = resultDict["data"] as? [[String : AnyObject]] else {
                return
            }
            
            self.perrtyGroup.tag_name = "颜值"
            self.perrtyGroup.icon_name = "home_header_phone"
            
            //获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.perrtyGroup.anchors.append(anchor)
            }
            dGroup.leave()
            
        }
        
        //3.2 请求游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1545917273
        dGroup.enter()
        NetWorkTool.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", .get, parameters:parameters) { (result) in
            
            //print(result)
            
            //将json 转换成字典
            guard let resultDict = result  as? [NSString : AnyObject] else { return }
            
            guard let dataArray  = resultDict["data"] as? [[String : AnyObject]] else {
                return
            }
            
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            dGroup.leave()
        }
        
        //请求完所有数据发送通知 更新界面 放主线程
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.perrtyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finistedCallBack()
        }
    }

    //轮播数据
    func requestCycleData(_ finistedCallBack : @escaping ()->()){
        NetWorkTool.requestData(urlString: "http://www.douyutv.com/api/v1/slide/6", .get, parameters: ["version" : "2.300"]) { (result) in
            
            //1.获取字典信息
            guard let resultDict = result as? [NSString : NSObject] else { return }
            
            //2.获取key值对应的数组
            guard let resultArray = resultDict["data"] as? [[NSString : NSObject]] else { return }
            
            //3.将字典转换为模型
            for dict in resultArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }

            finistedCallBack()
        }
    }
    
}









