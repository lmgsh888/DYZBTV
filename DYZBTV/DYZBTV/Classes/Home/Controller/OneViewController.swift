//
//  OneViewController.swift
//  DYZBTV
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    
    lazy var arrays = ["魔兽世界","DOTO","红警"]
    //MARK: - 定义属性
    var paramId : String = "" {
        didSet {
             print("传递的参数为:",paramId)
            
            let IparamId = Int(paramId)!
            

            if IparamId <= 2 {
                print(arrays[IparamId])
                titleLabel.text = "这是数组中的数据：" + arrays[IparamId]
            }else{
                titleLabel.text = "数组再无其它数据!"
            }
        }
    }
    
    lazy var titleLabel : UILabel = {
       let label = UILabel()
       label.frame = CGRect(x: 0, y: 50, width: KScreenW, height: 50)
        label.textColor = UIColor.white
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.brown
        
        self.view.addSubview(titleLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
