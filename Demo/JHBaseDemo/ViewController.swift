//
//  ViewController.swift
//  JHBaseDemo
//
//  Created by lifei on 2021/8/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let testVC = JHTestVC.init(title: "测试")
        testVC.modalPresentationStyle = .fullScreen
        self.present(testVC, animated: true, completion: nil)
    }

}

