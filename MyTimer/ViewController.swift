//
//  ViewController.swift
//  MyTimer
//
//  Created by Daisuke Doi on 2022/11/30.
//



/*
 Tips メソッドの書き方
 
 func hogeHoge(_ huga:Int hogo:Str) -> Bool {
  return =
 }
 
 hogeHoge が メソッド名
 _　が　ラベル、設定しない場合は"_"とかく　ラベルによって引数を保管できる？
 huga が 第一引数　:Int が第一引数の型指定
 hogo　が　第二引数　:Str が第二引数の型指定
 -> Bool が　戻り値の型宣言　この肩の通りの戻り値がこないとエラーおこす
 return = で代入される値が戻り値になる

  
 */



import UIKit

class ViewController: UIViewController {
    
    //タイマーの変数を作成
    var timer : Timer?
    //カウントの変数を作成
    var count = 0
    //設定値を扱うキーを設定
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        //UserDefaultsに初期値を登録
        settings.register(defaults:[settingKey:10])
    }
    
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        //timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
        //もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                //タイマー停止
                nowTimer.invalidate()
            }
        }
        //画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        //timerをアンラップしてnowTimerに代入
        if let nowTimer = timer{
            //もしタイマーが実行中だったらスタートしない　という分岐
            if nowTimer.isValid == true {
                //実行中だったら何も処理しない、つまり
                return
            }
        }
        
        //タイマーをスタート(Timerクラスをインスタンス化、引数を渡す)
        timer = Timer.scheduledTimer(timeInterval:1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    @IBAction func stopButtonAction(_ sender: Any) {
        //timerをアンラップしてnowtimerに代入
        if let nowTimer = timer {
            //もし　タイマーが実行中だったら停止
            if nowTimer.isValid == true{
                //タイマー停止
                nowTimer.invalidate()
            }
        }
    }
    
    
    //画面の更新をする(戻り値 : remainCount:残り時間)
    func displayUpdate() -> Int {
        //UserDefaults のインスタンスを生成 初期値は10
        let settings = UserDefaults.standard
        //取得した秒数をtimeValueに渡す
        let timerValue = settings.integer(forKey: settingKey)
        //残り時間(remainCount)を生成
        let remainCount = timerValue - count
        //remainCount(残り時間)をラベルに表示
        countDownLabel.text = "残り\(remainCount)秒"
        //残り時間を戻り値に設定
        return remainCount
    }
    //経過時間の処理
    @objc func timerInterrupt(_ timer:Timer){
        //count(経過時間)に＋1していく
        count += 1
        //remainCount(残り時間)が0以下の時、タイマーを止める
         if displayUpdate() <= 0 {
            //初期化処理 経過時間分のタイマーの数値を初期化する
            count = 0
            //タイマー停止
            timer.invalidate()
            //カスタマイズ編　ダイアログを作成
            let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
            //ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            //アクションを追加 インスタンス化したdefaultActionをalertControllerに渡す
            alertController.addAction(defaultAction)
            //ダイアログの表示　presentが表示する　というメソッド
            present(alertController, animated: true, completion: nil)
        }
    }

    //画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        //カウント(経過時間)をゼロにする
        count = 0
        //タイマーの表示を更新する
        _ = displayUpdate()
    }
}




