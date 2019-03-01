//
//  ViewController.swift
//  iOS_Sign_Swift
//
//  Created by Ryan on 2019/2/28.
//  Copyright © 2019 Ryan. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height


class ViewController: UIViewController {

    var signImageView: UIImageView!
    var signView: SignView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signImageView = UIImageView.init(frame: CGRect.init(x: (kScreenWidth - 200)/2, y: 100, width: 200, height: 100))
        signImageView.layer.borderColor = UIColor.blue.cgColor
        signImageView.layer.borderWidth = 3.0
        self.view.addSubview(signImageView)
        signImageView.isHidden = true
        
        signView = SignView.init(frame: CGRect.init(x: 10, y: 300, width: kScreenWidth - 20, height: (kScreenWidth - 20)/2))
        signView.layer.borderColor = UIColor.blue.cgColor
        signView.layer.borderWidth = 3.0
        self.view.addSubview(signView)
        
        let cancelButton = UIButton.init(frame: CGRect.init(x: kScreenWidth/2 - 100, y: 500, width: 50, height: 30))
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.blue, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction) , for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        let commitButton = UIButton.init(frame: CGRect.init(x: kScreenWidth/2 + 50, y: 500, width: 50, height: 30))
        commitButton.setTitle("确定", for: .normal)
        commitButton.setTitleColor(.blue, for: .normal)
        commitButton.addTarget(self, action: #selector(commitAction) , for: .touchUpInside)
        self.view.addSubview(commitButton)
    }

    @objc func cancelAction() {
        signView.clear()
    }
    
    @objc func commitAction() {
        if let signImage = signView.getSignImage() {
            signImageView.image = signImage
            signImageView.isHidden = false
        }
    }
}

