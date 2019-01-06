//
//  NetWorkTool.swift
//  DYZBTV
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}



class NetWorkTool {
    class func requestData(urlString : String,_ type : MethodType,parameters : [String : Any]? = nil,finishedCallback: @escaping(_ result : Any)->()){
        
        //1.获取请求网络的方式
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallback(result)
        }
    }
}
