//
//  CustomViewOwner.swift
//  SampleCustomView
//
//  Created by 三浦　登哉 on 2021/03/30.
//

import UIKit

final class CustomViewOwner: NSObject {
    
    var customView: UIView!
    @IBOutlet weak var callegeLabel1: UILabel!
    @IBOutlet weak var callegeLabel2: UILabel!
    @IBOutlet weak var callegeLabel3: UILabel!
    @IBOutlet private weak var buttom1: UIButton!
    @IBOutlet private weak var buttom2: UIButton!
    @IBOutlet private weak var buttom3: UIButton!
    
    override init() {
        super.init()
        customView = UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as?  UIView
        callegeLabel1.text = ""
        callegeLabel2.text = ""
        callegeLabel3.text = ""
    }
    
    func setData(history1: String?, history2: String?, history3: String?) {
        callegeLabel1.text = history1
        callegeLabel2.text = history2
        callegeLabel3.text = history3
    }
}
