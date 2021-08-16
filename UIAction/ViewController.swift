//
//  ViewController.swift
//  UIAction
//
//  Created by hb on 2021/5/7.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hbBtn: UIButton!
    @IBOutlet weak var HbBtn2: UIButton!
    let swi = UISwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a closure-based action to use as a menu element.
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "首页"
        swi.addTarget(self, action: #selector(self.clickswi), for: .valueChanged)
        swi.isOn = false
        swi.center = self.view.center
        swi.addAction(UIAction{action in
            _ = action.sender as! UISwitch
            print("点击了")
        }, for: .valueChanged)
        self.view.addSubview(swi)
        
        hbBtn.addTarget(self, action: #selector(hbBtnAction), for: .touchUpInside)
        HbBtn2.addTarget(self, action: #selector(hbBtnAction2), for: .touchUpInside)
    }
    
    
    
    @objc func hbBtnAction(){
        print("111")
        let vc1 = vc1()
        self.present(vc1, animated: true, completion: nil)
    }
    
    @objc func hbBtnAction2(){
        print("222")
        self.navigationController?.pushViewController(vc1(), animated: true)
        /**   测试截图功能，占满全屏，除了导航栏
         UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0)
         if let context = UIGraphicsGetCurrentContext() {
             self.view.layer.render(in: context)
         }
         let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
         UIGraphicsEndImageContext()
         let hbuiimage = UIImageView(image: image)
         hbuiimage.frame = self.view.bounds
         self.view.addSubview(hbuiimage)
         */
    }

    
    @objc func clickswi (){
        if swi.isOn == true{
            let alertC = UIAlertController.init(title: "您未安装手机淘宝APP,是否前往AppStore下载安装？", message: nil, preferredStyle: UIAlertController.Style.alert)
            
            alertC.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: { [self](action:UIAlertAction) in
                swi.isOn = false
            }))
            alertC.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { [self](action:UIAlertAction) in
                swi.isOn = true
            }))
            self.present(alertC, animated: true, completion: nil)

        }
    }
    
}

