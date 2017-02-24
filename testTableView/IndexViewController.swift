//
//  IndexViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/3.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {
    var token : JSON = []
    var key = String ()
    override func viewDidLoad() {
        super.viewDidLoad()
  print(token)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "userinfo"){
            
            
            let nav = segue.destination as! UINavigationController
            let destinationController = nav.topViewController as! AnimalTableViewController
            destinationController.userinfo = self.token
            destinationController.key = self.key
            
        }
        if(segue.identifier == "userinfotouser"){
            
            
            let nav = segue.destination as! UINavigationController
            let destinationController = nav.topViewController as! MenberViewController
            destinationController.userinfo = self.token
            destinationController.key = self.key
            
            
        }
        if(segue.identifier == "usertoupdata"){
            
            
            let nav = segue.destination as! UINavigationController
            let destinationController = nav.topViewController as! UpdataAnimalViewController
            destinationController.userinfo = self.token
            destinationController.key = self.key
            
        }
        if (segue.identifier  == "showsolong"){
            let nav = segue.destination as! UINavigationController
            let destinationController = nav.topViewController as! ViewController
            destinationController.userinfo = self.token
            
        }
        if (segue.identifier  == "tomap"){
        let destinationController = segue.destination as!  HelpMapViewController
            destinationController.userinfo = self.token
            destinationController.key = self.key
  
        }
        if (segue.identifier  == "goHelper"){
            let destinationController = segue.destination as!  LittleHelpViewController
            destinationController.userinfo = self.token
            destinationController.key = self.key
            
        }
}
    
    @IBAction func BtnUpdata(_ sender: Any) {
        
        if(token.count == 0)
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
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "usertoupdata"{
            if (token.count != 0)
            {
                return true
            }
            
        }
        if identifier == "userinfotouser"{
            return true
            
        }
       
        if identifier == "userinfo"{
            return true
            
        }
        if identifier == "showsolong"{
          return true
        }
        if identifier == "tomap"{
            return true
        }
        
        if identifier == "goHelper"{
            return true
        }
        return false
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


