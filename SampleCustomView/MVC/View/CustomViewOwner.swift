//
//  CustomViewOwner.swift
//  SampleCustomView
//
//  Created by 三浦　登哉 on 2021/03/30.
//

import UIKit

class CustomViewOwner: NSObject {
    
    var customView: UIView!
    @IBOutlet weak var callegeLabel1: UILabel!
    @IBOutlet weak var callegeLabel2: UILabel!
    @IBOutlet weak var callegeLabel3: UILabel!
    
    override init() {
        super.init()
        customView = UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as?  UIView
    }
    
    func setData(callege1: String, callege2: String, callege3: String) {
        callegeLabel1.text = callege1
        callegeLabel2.text = callege2
        callegeLabel3.text = callege3
    }
}
