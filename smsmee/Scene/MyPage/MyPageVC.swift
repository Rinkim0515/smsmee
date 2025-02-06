//
//  MyPageVC.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//

import UIKit

class TestViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testView = TestView1(frame: view.bounds)
        view.addSubview(testView)
    }
}
