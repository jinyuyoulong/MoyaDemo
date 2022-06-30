//
//  ViewController.swift
//  MoyaDemo
//
//  Created by yjkj on 2022/6/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ConfigAPIs.simpleFetchData()
        ConfigAPIs.getGifts()
    }


}

