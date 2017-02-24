//
//  MenberViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/8.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class MenberViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var btnlist: UIButton!
    var userinfo : JSON = []
  
    @IBOutlet weak var textmsg: UILabel!
    @IBOutlet weak var btnMSG: UIButton!
    var text = "http://twpetanimal.ddns.net:9487/api/v1/Account/ExternalLogin?provider=Facebook&response_type=token&client_id=self&redirect_uri=http%3A%2F%2Ftwpetanimal.ddns.net%3A9487%2F&state=SP4MrOwaqz22ISmbTdqPPj3hQPCcxNKcvWgJCndt0Yo1"
    
    var postUrltoken = "http://twpetanimal.ddns.net:9487/token"
    
    var checkurl = "http://twpetanimal.ddns.net:9487/api/v1/Account/UserInfo"
    var key = String()
    override func viewDidLoad() {
        super.viewDidLoad()
   if(userinfo.count == 0)
   {
  //  btnMSG.isHidden = true
    //btnlist.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnReg(_ sender: Any) {
  
    }

    @IBAction func BtnLogin(_ sender: Any) {
        

    }
 
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "usertomsg"){
            
            
        
            let destinationController = segue.destination as! MessageTableViewController
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
            
        }
        
        if(segue.identifier == "tomycatchanimal"){
         let destinationController = segue.destination as! AnimalTableViewController
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
         /*   String url = "http://twpetanimal.ddns.net:9487/api/v1/AnimalDatas?$orderby=animalDate desc";
            url += "&$filter=animalGetter_userID eq '"+UserName+"'";*/
            
           
            destinationController.urlString =  "http://twpetanimal.ddns.net:9487/api/v1/AnimalDatas?$orderby=animalDate%20desc&$filter=animalGetter_userID%20eq%20%27\(userinfo["Email"])%27"
        }
        if(segue.identifier == "backindex"){
            
            
            
            let destinationController = segue.destination as! IndexViewController
            destinationController.token = self.userinfo
             destinationController.key = self.key
        }
        if(segue.identifier == "tofollow"){
            
            
            
            let destinationController = segue.destination as! FollowTableViewController
            destinationController.userinfo = self.userinfo
             destinationController.key = self.key
            
        }
        if(segue.identifier == "toselfanimal"){
            
            
            
            let destinationController = segue.destination as! AnimalTableViewController
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
            destinationController.urlString = "http://twpetanimal.ddns.net:9487/api/v1/animalDatas?$filter=animalOwner_userID%20eq%20%27\(userinfo["UserId"])%27"
        }    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


