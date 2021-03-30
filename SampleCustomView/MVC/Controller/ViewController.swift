//
//  ViewController.swift
//  SampleCustomView
//
//  Created by 三浦　登哉 on 2021/03/30.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var textField3: UITextField!
    // 検索履歴を表示するカスタムビューのオーナー
    private var customViewOwner1: CustomViewOwner?
    private var customViewOwner2: CustomViewOwner?
    private var customViewOwner3: CustomViewOwner?
    // 検索履歴を表示するカスタムビュー
    private var customView1: UIView!
    private var customView2: UIView!
    private var customView3: UIView!
    // 検索履歴を格納する配列
    private var searchHistroyArray: [SearchHistory] = []
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    override func loadView() {
        super.loadView()
        customViewOwner1 = CustomViewOwner()
        customViewOwner2 = CustomViewOwner()
        customViewOwner3 = CustomViewOwner()
        
        customView1 = customViewOwner1?.customView
        customView2 = customViewOwner2?.customView
        customView3 = customViewOwner3?.customView
        
        customView1.translatesAutoresizingMaskIntoConstraints = false
        customView2.translatesAutoresizingMaskIntoConstraints = false
        customView3.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customView1)
        view.addSubview(customView2)
        view.addSubview(customView3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        
        customView1.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        customView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        customView1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        customView1.isHidden = true
        
        customView2.topAnchor.constraint(equalTo: textField2.bottomAnchor).isActive = true
        customView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        customView2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        customView2.isHidden = true
        
        customView3.topAnchor.constraint(equalTo: textField3.bottomAnchor).isActive = true
        customView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        customView3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        customView3.isHidden = true
    }
    
    @IBAction func search(_ sender: Any) {
        guard let callege1 = textField.text,
              let callege2 = textField2.text,
              let callege3 = textField3.text else { return }
        // 入力された文字をUserDefaultsに保存
        // 配列に追加する要素
        let searchHistory = SearchHistory(first: callege1, second: callege2, third: callege3)
        searchHistroyArray.insert(searchHistory, at: 0)
        print(searchHistroyArray.count)
        // SnakeCaseに変換
        encoder.keyEncodingStrategy = .convertToSnakeCase
        // エンコード
        guard let data = try? encoder.encode(searchHistroyArray) else { return }
        // UserDefaultsにデータを保存
        UserDefaults.standard.set(data, forKey: "SearchHistory")
    }
}

extension ViewController: UITextFieldDelegate {
    // 検索履歴表示
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // UserDefaultsからデータを取得
        guard let callegeSearchData = UserDefaults.standard.data(forKey: "SearchHistory"),
              let callegeHistory = try? decoder.decode([SearchHistory].self, from: callegeSearchData) else { return }
        // カスタムビューのラベルに取得したデータを表示させる
        customViewOwner1?.callegeLabel1.text = callegeHistory[safe: 0]?.first
        customViewOwner1?.callegeLabel2.text = callegeHistory[safe: 1]?.second
        customViewOwner1?.callegeLabel3.text = callegeHistory[safe: 2]?.third
        // 場合分け
        switch textField {
        case self.textField:
            customView1.isHidden = false
        case self.textField2:
            customView2.isHidden = false
        case self.textField3:
            customView3.isHidden = false
        default:
            break
        }
    }
    
    // 検索履歴閉じる
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.textField:
            customView1.isHidden = true
        case self.textField2:
            customView2.isHidden = true
        case self.textField3:
            customView3.isHidden = true
        default:
            break
        }
    }
}

extension Array {
    subscript (safe index: Index) -> Element? {
        //indexが配列内なら要素を返し、配列外ならnilを返す（三項演算子）
        return indices.contains(index) ? self[index] : nil
    }
}
