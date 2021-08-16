//
//  vc1.swift
//  UIAction
//
//  Created by hb on 2021/8/16.
//

import UIKit

class vc1: UIViewController {
    lazy var nav:UIView={
        let nav = UIView()
        nav.backgroundColor = UIColor(red: 255.0/255.0, green: 104.0/255.0, blue: 22.0/255.0, alpha: 1.0)
        nav.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 88)
        let text = UILabel()
        text.text = "自定义导航栏"
        text.sizeToFit()
        nav.addSubview(text)
        text.center = nav.center
        return nav
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(nav)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
