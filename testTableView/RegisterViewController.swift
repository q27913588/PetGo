//
//  RegisterViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/9.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class RegisterViewController: UIViewController,UITextFieldDelegate,NVActivityIndicatorViewable  {
    @IBOutlet weak var TextChPassword: UITextField!
    @IBOutlet weak var Textpassword: UITextField!

    @IBOutlet weak var TextEmail: UITextField!
   
    @IBOutlet weak var uername: UITextField!

    var postUrl = "http://twpetanimal.ddns.net:9487/api/v1/Account/Register"
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func BtnRegist(_ sender: Any) {

        
        let account : JSON =
            [
                "UserName" : uername.text!,
                "Email": TextEmail.text!,
                "Password": Textpassword.text!,
                "ConfirmPassword": TextChPassword.text!
                
        ]
        let url:NSURL = NSURL(string: postUrl)!;
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
            if (responseString != "")
            {
             self.alert(message: "註冊失敗，資料格式不符合規範")
            }else {
        self.alert(message: "註冊成功！")
            }
    
            print("responseString = \(responseString)")
            
        }
        task.resume()
      
    }
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
