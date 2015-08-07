//
//  ViewController.swift
//  tickleApp
//
//  Created by Kanako Kobayashi on 2015/08/08.
//  Copyright (c) 2015年 Kanako Kobayashi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let requestUrl = "http://localhost:4567/"
    var titleArray = NSArray()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    /*
    * メッセージを表示する処理
    * サーバから、メッセージを取得します。
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 通常のGetリクエスト
        //Alamofire.request(.GET, requestUrl)
        // 非同期のGetリクエスト
        Alamofire.request(.GET, requestUrl).responseJSON
            {(request, response, json, error) in
            let jsonDic = json as! NSDictionary
            let responseData = jsonDic["responseData"] as! NSDictionary
            self.titleArray = responseData["results"] as! NSArray
            self.titleLabel.text = self.titleArray[0]["title"] as? String
            self.messageLabel.text = self.titleArray[0]["message"] as? String
        }
    }
    
    /*
    * メッセージを保存する処理
    * サーバに、メッセージを送信します。
    */
    @IBAction func sendMessage(sender: AnyObject) {
        println(self.inputText.text)
        let parameters = ["comment": self.inputText.text]
        Alamofire.request(.POST, requestUrl + "/new", parameters: parameters)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


