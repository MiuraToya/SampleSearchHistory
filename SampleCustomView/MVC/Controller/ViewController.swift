//
//  ViewController.swift
//  SampleCustomView
//
//  Created by 三浦　登哉 on 2021/03/30.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var callegeText: UITextField!
    @IBOutlet private weak var lessonText: UITextField!
    @IBOutlet private weak var teacherText: UITextField!
    @IBOutlet private  weak var searchButton: UIButton!
    // 検索履歴を表示するカスタムビューのオーナー
    private var customViewOwner1: CustomViewOwner?
    private var customViewOwner2: CustomViewOwner?
    private var customViewOwner3: CustomViewOwner?
    // 検索履歴を表示するカスタムビュー
    private var customView1: UIView!
    private var customView2: UIView!
    private var customView3: UIView!
    // 検索履歴を格納する配列
    private var callegeHistroyArray: [CallegeHistory] = []
    private var lessonHistroyArray: [LessonHistory] = []
    private var teacherHistroyArray: [TeacherHistory] = []
    
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
        callegeText.delegate = self
        lessonText.delegate = self
        teacherText.delegate = self
        
        customView1.topAnchor.constraint(equalTo: callegeText.bottomAnchor).isActive = true
        customView1.bottomAnchor.constraint(equalTo: lessonText.topAnchor).isActive = true
        customView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        //customView1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        customView1.isHidden = true
        
        customView2.topAnchor.constraint(equalTo: lessonText.bottomAnchor).isActive = true
        customView2.bottomAnchor.constraint(equalTo: teacherText.topAnchor).isActive = true
        customView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
       // customView2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        customView2.isHidden = true
        
        customView3.topAnchor.constraint(equalTo: teacherText.bottomAnchor).isActive = true
        customView3.bottomAnchor.constraint(equalTo: searchButton.topAnchor).isActive = true
        customView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
       // customView3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        customView3.isHidden = true
    }
    
    @IBAction private func search(_ sender: Any) {
        guard let callege = callegeText.text,
              let lesson = lessonText.text,
              let teacher = teacherText.text else { return }
        // 入力された文字をUserDefaultsに保存
        // 配列に追加する要素
        if !callege.isEmpty {
            let callegeHistory = CallegeHistory(callege: callege)
            callegeHistroyArray.insert(callegeHistory, at: 0)
        }
        if !lesson.isEmpty {
            let lessonHistory = LessonHistory(lesson: lesson)
            lessonHistroyArray.insert(lessonHistory, at: 0)
        }
        if !teacher.isEmpty {
            let teacherHistroy = TeacherHistory(teacher: teacher)
            teacherHistroyArray.insert(teacherHistroy, at: 0)
        }
        // SnakeCaseに変換
        encoder.keyEncodingStrategy = .convertToSnakeCase
        // エンコード
        guard let callegeData = try? encoder.encode(callegeHistroyArray),
              let lessonData = try? encoder.encode(lessonHistroyArray),
              let teacherData = try? encoder.encode(teacherHistroyArray) else { return }
        // UserDefaultsにデータを保存
        UserDefaults.standard.set(callegeData, forKey: "callegeHistory")
        UserDefaults.standard.set(lessonData, forKey: "lessonHistory")
        UserDefaults.standard.set(teacherData, forKey: "teacherHistory")
    }
}

extension ViewController: UITextFieldDelegate {
    // 検索履歴表示
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 大学名の履歴を取得
        guard let callegeSearchData = UserDefaults.standard.data(forKey: "callegeHistory"),
              let callegeHistory = try? decoder.decode([CallegeHistory].self, from: callegeSearchData) else { return }
        // 講義名の履歴を取得
        guard let lessonSearchData = UserDefaults.standard.data(forKey: "lessonHistory"),
              let lessonHistory = try? decoder.decode([LessonHistory].self, from: lessonSearchData)
        else { return }
        // 教員名の履歴を取得
        guard let teacherSearchData = UserDefaults.standard.data(forKey: "teacherHistory"),
              let teacherHistory = try? decoder.decode([TeacherHistory].self, from: teacherSearchData)
        else { return }
        // カスタムビューのラベルに取得したデータを表示させる
        // 大学名の履歴
        let callege1 = callegeHistory[safe: 0]?.callege
        let callege2 = callegeHistory[safe: 1]?.callege
        let callege3 = callegeHistory[safe: 2]?.callege
        // カスタムビューに履歴表示
        customViewOwner1?.setData(history1: callege1, history2: callege2, history3: callege3)
        // 講義名の履歴
        let lesson1 = lessonHistory[safe: 0]?.lesson
        let lesson2 = lessonHistory[safe: 1]?.lesson
        let lesson3 = lessonHistory[safe: 2]?.lesson
        // カスタムビューに履歴表示
        customViewOwner2?.setData(history1: lesson1, history2: lesson2, history3: lesson3)
        // 教員名の履歴
        let teacher1 = teacherHistory[safe: 0]?.teacher
        let teacher2 = teacherHistory[safe: 1]?.teacher
        let teacher3 = teacherHistory[safe: 2]?.teacher
        // カスタムビューに表示
        customViewOwner3?.setData(history1: teacher1, history2: teacher2, history3: teacher3)
        // 場合分け
        switch textField {
        case self.callegeText:
            customView1.isHidden = false
        case self.lessonText:
            customView2.isHidden = false
        case self.teacherText:
            customView3.isHidden = false
        default:
            break
        }
    }
    
    // 検索履歴閉じる
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.callegeText:
            customView1.isHidden = true
        case self.lessonText:
            customView2.isHidden = true
        case self.teacherText:
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
