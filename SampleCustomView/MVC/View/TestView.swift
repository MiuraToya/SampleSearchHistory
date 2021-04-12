//
//  TestView.swift
//  SampleCustomView
//
//  Created by 三浦　登哉 on 2021/04/02.
//

import UIKit

class TestView: UIView {
    @IBOutlet weak var history1: UILabel!
    @IBOutlet weak var history2: UILabel!
    @IBOutlet weak var history3: UILabel!
    @IBOutlet weak var buttom: UIButton!
    @IBOutlet weak var buttom2: UIButton!
    @IBOutlet weak var buttom3: UIButton!
    private let decoder = JSONDecoder()
    override init(frame: CGRect) {
           super.init(frame: frame)
           loadNib()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           loadNib()
        history1.text = ""
        history2.text = ""
        history3.text = ""
        
       }
       
       private func loadNib() {
           if let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)?.first as? UIView {
               view.frame = self.bounds
               self.addSubview(view)
           }
       }
    @IBAction func tappe1(_ sender: Any) {
        
    }
    
    func setData(history1: String?, history2: String?, history3: String?) {
       /* guard let _histsory1 = self.history1.text else { return }
        guard let _histsory2 = self.history2.text else { return }
        guard let _histsory3 = self.history3.text else { return }*/
       
        /*if _histsory1.isEmpty {
            print("koko1")
            buttom.isHidden = true
        } else {
            buttom.isHidden = false
        }
        if _histsory2.isEmpty {
            print("koko2")
            buttom2.isHidden = true
        } else {
            buttom2.isHidden = false
        }
        if _histsory3.isEmpty {
            print("koko3")
            buttom3.isHidden = true
        } else {
            buttom3.isHidden = false
        }*/
        
        self.history1.text = history1
        self.history2.text = history2
        self.history3.text = history3
    }
}
