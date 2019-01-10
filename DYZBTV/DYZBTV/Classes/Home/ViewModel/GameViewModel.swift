//
//  GameViewModel.swift
//  DYZBTV
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    
    lazy var games : [GameModel] = [GameModel]()

}

extension GameViewModel {
    //MARK: - 请求游戏分组数据
   func requestAllGameData(_ finistedCallBack :@escaping () -> ()) {
    //http://capi.douyucdn.cn/api/v1/getColumnDetail?short_name=game
    NetWorkTool.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", .get, parameters: ["short_name":"game"]) { (result) in
        
        //1.获取字典信息
        guard let resultDict = result as? [NSString : Any] else { return }
        //2.获取data key值得数组
        guard let resultArray = resultDict["data"] as? [[NSString : Any]] else { return }
        
        //将字典转模型
        for dict in resultArray {
            self.games.append(GameModel(dict: dict as [String : Any]))
        }
            finistedCallBack()
        }

    }
}
