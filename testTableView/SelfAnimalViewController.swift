//
//  SelfAnimalViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/10.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit
import Kingfisher
class SelfAnimalViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
 var AnimalImageview = UIImage()
    var key = String()
    
    var userid = String()
    var animalname = String()
    var animalsex = String()
    var animalhealth = String()
    var animalcolor = String()
    var animaldetail = String()
    var animaladress = String()
    var animaltype = String()
    var animalID  = Int()
    var userinfo : JSON = []
    @IBOutlet weak var textname: UILabel!
    
    @IBOutlet weak var textsex: UILabel!
    
    @IBOutlet weak var textheal: UILabel!
    
    @IBOutlet weak var texttype: UILabel!
    
    @IBOutlet weak var textcolor: UILabel!
    
    @IBOutlet weak var textadress: UILabel!
    
    @IBOutlet weak var textdetail: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if(userinfo.count == 0)
        
        {
        print("尚未登入")
        }
        
        print(userinfo)
        textsex.text = animalsex
        textname.text = animalname
        textheal.text = animalhealth
        texttype.text = animaltype
        textcolor.text = animalcolor
        textadress.text = animaladress
        textdetail.text = animaldetail
        
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.kf.indicatorType = .activity
        image.image = AnimalImageview
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "board"){
            let destinationController = segue.destination as! BoradTableViewController
            destinationController.boradID = self.animalID
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
        }
        
    }
    

    @IBAction func btnsend(_ sender: Any) {
        if(userinfo.count == 0)
        {
            let alertController = UIAlertController(
                title: "提示",
                message: "請先登入會員",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    
            })
            alertController.addAction(okAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
 
            }
        else
        {
            let alertController = UIAlertController(
                title: "提示",
                message: "已加入發送認養訊息",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    
                    
                    let account : JSON =
                        [
                            "msgID": 0,
                            "msgTime": "string",
                            "msgFrom_userID": self.userinfo["UserId"],
                            "msgTo_userID": self.userid,
                            "msgType": "認養通知",
                            "msgFromURL": "null",
                            "msgContent": "您好我想認養您的寵物請聯絡我",
                            "msgRead": "未讀"
                    ]
                    
                    let url:NSURL = NSURL(string:"http://twpetanimal.ddns.net:9487/api/v1/MsgUsers"
                        )!;
                    let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    request.setValue("Bearer "+self.key, forHTTPHeaderField: "Authorization")
                    request.httpMethod = "POST";
                    request.httpBody = try! account.rawData()
                    //try! animal.rawData()
                    
                    /*try! JSONSerialization.data(withJSONObject: animal, options: [])*/
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest) {
                        data, response, error in
                        
                        if error != nil {
                            print("error=\(error)")
                            return
                        }
                        
                        print("response = \(response)")
                        
                        //將收到的資料轉成字串print出來看看
                        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        print("responseString = \(responseString)")
                        
                    }
                    task.resume()
                    
                    
                    
                    
            })
            alertController.addAction(okAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
            
        }

        
     
        }
        
    
    
    
    @IBAction func Btnfavorit(_ sender: Any) {
        if(userinfo.count == 0)
        {
            let alertController = UIAlertController(
                title: "提示",
                message: "請先登入會員",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    
            })
            alertController.addAction(okAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
            
        } else
        {
            let alertController = UIAlertController(
                title: "提示",
                message: "已加入追蹤清單",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    
                    
                    let account : JSON =
                        [
                            
                            "follow_userId": self.userinfo["UserId"],
                            "follow_animalID": self.animalID
                    ]
                    
                    let url:NSURL = NSURL(string:"http://twpetanimal.ddns.net:9487/api/v1/followAnis"
                        )!;
                    let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    request.setValue("Bearer "+self.key, forHTTPHeaderField: "Authorization")
                    request.httpMethod = "POST";
                    request.httpBody = try! account.rawData()
                    //try! animal.rawData()
                    
                    /*try! JSONSerialization.data(withJSONObject: animal, options: [])*/
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest) {
                        data, response, error in
                        
                        if error != nil {
                            print("error=\(error)")
                            return
                        }
                        
                        print("response = \(response)")
                        
                        //將收到的資料轉成字串print出來看看
                        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        print("responseString = \(responseString)")
                        
                    }
                    task.resume()
                    
                    
                    
                    
            })
            alertController.addAction(okAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
            
        }

    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
