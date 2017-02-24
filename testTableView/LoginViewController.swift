//
//  LoginViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/11.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var checkurl = "http://twpetanimal.ddns.net:9487/api/v1/Account/UserInfo"
var postUrltoken = "http://twpetanimal.ddns.net:9487/token"
    var tempResult = "123"
      var UserInfo : JSON = []
    @IBOutlet weak var TextEmail: UITextField!
    
    @IBOutlet weak var TextPassword: UITextField!
    var token = ""
    var email = String()
    var password = String()
    var check = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check = ""
       // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BtnLogin(_ sender: Any) {
       
      // self.performSegue(withIdentifier: "login", sender: self)
        /*"username=blueness927@gmail.com&password=Jack@0927&grant_type=password"*/
        email = TextEmail.text!
        password = TextPassword.text!
        
        let accountToken = "username=\(email)&password=\(password)&grant_type=password"
        var postData = accountToken.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let postLength = "\(postData?.count)"
        
        let url:NSURL = NSURL(string: postUrltoken)!;
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST";
        request.httpBody = postData
        //try! animal.rawData()
        
        /*try! JSONSerialization.data(withJSONObject: animal, options: [])*/
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
        let  Jdata = JSON(data : data!)
            if let name = Jdata["access_token"].string {
                self.token = name
                print(name)
            }
            
            //將收到的資料轉成字串print出來看看
            let responseString = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            if( responseString?.range(of: "使用者名稱或密碼不正確") != nil)
            {
              self.alert(message: "登入失敗，帳號或密碼錯誤")
                
            }else{
                let url:NSURL = NSURL(string: self.checkurl)!;
                let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                request.setValue("Bearer "+self.token, forHTTPHeaderField: "Authorization")
                request.httpMethod = "GET";
                
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
                    
                    self.UserInfo = JSON(data : data!)
                    print("responseString = \(responseString)")
                    
                }
                task.resume();
                
                
                self.alert(message: "登入成功")
                self.check = "pass"
               
            
            }
            
            
            print("responseString = \(responseString)")
            
            
        }
        task.resume();
       
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "login"{
                    if (check == "pass")
            {
                return true
            }
            
            if identifier == "toregist"{
                
                    return true
            }
        }
         return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if(segue.identifier == "login"){
        let destinationController = segue.destination as! IndexViewController
        destinationController.token = self.UserInfo
        destinationController.key = self.token
        }
        
        }
        

    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {
             (action: UIAlertAction!) -> Void in
            if(self.check == "pass")
            {
                self.performSegue(withIdentifier: "login", sender: self)
                
            }
            
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
  
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


