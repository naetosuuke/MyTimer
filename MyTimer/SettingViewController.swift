//
//  SettingViewController.swift
//  MyTimer
//
//  Created by Daisuke Doi on 2022/12/01.
//

import UIKit

//ここで親クラスSettingViewControllerに①UIViewController(画面のクラス), ②UIPickerViewDataSource(選択画面のクラス)、
//③ UIPickerViewDelegate(他クラスへの通知プロトコル) の3つの子クラスを定義　(型みたいな書き方する)


class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    //UIPickerViewに表示するデータをArrayで作成
    //PickerVIewに表示させるデータをInt型の配列として宣言。
    //いろんな値をいれる、変数、定数、配列、辞書,タプルなどの入れ物をデータ構造と呼ぶ
    
    let settingArray : [Int] = [10,20,30,40,50,60]
    
    //設定値を覚えるキーを設定
    //カウント画面で用いる秒と共通利用する　値が紐づくのでキーは文字型でよい
    //キーそのものは変わらず、紐づいた値が変動するだけなので、定数として宣言してOK
    let settingKey = "timer_value"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //timerSettingPickerのデリゲートとデータソースの通知先を指定
        //PickerViewを使うために、delegateとdataSourceの通知先を指定する必要がある。
        //今回はSettingViewController自身で通知を受けたいので、self を指定。selfは自分自身のインスタンスを指定する　という意味
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        //UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey:settingKey)
        
        //Pickerの選択を合わせる
        for row in 0..<settingArray.count{
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
            
            
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    
    @IBAction func decisionButtonAction(_ sender: Any) {
    }
}
