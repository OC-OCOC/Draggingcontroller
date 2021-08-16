//
//  HBNavgationController.swift
//  UIAction
//
//  Created by hb on 2021/8/16.
//

import UIKit

class HBNavgationController: UINavigationController {
    //屏幕宽
    let HBScreenW = UIScreen.main.bounds.size.width

    //屏幕高
    let HBScreenH = UIScreen.main.bounds.size.height
    var jietuarr:[UIImage] = [UIImage]()
    let jietu:UIImageView = UIImageView()
    let cover:UIView = {
        let cover = UIView()
        cover.alpha = 0.5
        cover.backgroundColor = .darkGray
        return cover
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.creatScreenShot()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jietu.frame = self.view.bounds
        self.cover.frame = self.view.frame
        let hbgespan = UIPanGestureRecognizer(target: self, action: #selector(dragging(hbgespan:)))
        self.view.addGestureRecognizer(hbgespan)
    }
    
    func creatScreenShot(){
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0)
        if let context = UIGraphicsGetCurrentContext() {
            self.view.layer.render(in: context)
        }
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.jietuarr.append(image)
    }
    
    @objc func dragging(hbgespan:UIPanGestureRecognizer){
        if self.children.count <= 1 {return}
        
        let tx:CGFloat = hbgespan.translation(in: self.view).x
        let ty:CGFloat = hbgespan.translation(in: self.view).y
        print("x移动中\(tx),y移动中\(ty)")
        
        //停止移动
        if(hbgespan.state == .ended || hbgespan.state == .cancelled){
            
            let x:CGFloat = self.view.frame.origin.x
            let y:CGFloat = self.view.frame.origin.y
            print("x停止移动\(x),y停止移动\(y)")
            if(abs(x) >= self.view.frame.size.width * 0.35 || abs(y) >= self.view.frame.size.height * 0.35){
                UIView.animate(withDuration: 0.1) {
                    if x > 0 && y > 0 {
                        self.view.transform = CGAffineTransform(translationX: x, y: y)
                    }
//                    else if x>0 && y<0{
//                        self.view.transform = CGAffineTransform(translationX: self.view.frame.size.width, y: 88)
//                    }
//                    else if x<0 && y>0{
//                        self.view.transform = CGAffineTransform(translationX: self.view.frame.size.width, y: 88)
//                    }
//                    else if x<0 && y<0{
//                        self.view.transform = CGAffineTransform(translationX: self.view.frame.size.width, y: 88)
//                    }
                } completion: { finished in
                    self.popViewController(animated: false)
                    self.view.frame.size = CGSize(width: self.HBScreenW, height: self.HBScreenH)
                    self.jietu.removeFromSuperview()
                    self.cover.removeFromSuperview()
                    self.jietuarr.removeLast()
                    self.view.transform = CGAffineTransform(translationX: 0, y: 0) //CGAffineTransformIdentity
                }
            }
            else{
                UIView.animate(withDuration: 0.1, animations: { [self] in
                    self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.view.frame.size = CGSize(width: self.HBScreenW, height: self.HBScreenH)
                })
            }
        }
        else{ //正在拖拽
            //当拖拽导航控制器时，底部是黑色，所以需要添加上一个页面的截图来填充底部
            self.view.transform = CGAffineTransform(translationX: tx, y: ty + 88)
            //动态改变大小,拖拽结束要恢复大小
            self.view.frame.size = CGSize(width: min(HBScreenW - tx, HBScreenW), height: HBScreenH - tx - 88*2)
            let window = UIApplication.shared.keyWindow
            //将截图添加到最后面
            self.jietu.image = self.jietuarr[self.jietuarr.count - 2]
            window!.insertSubview(jietu, at: 0)
            window!.insertSubview(cover, aboveSubview: jietu)
        }
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        self.creatScreenShot()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
