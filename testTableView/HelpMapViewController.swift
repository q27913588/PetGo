//
//  HelpMapViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/16.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class HelpMapViewController: UIViewController {
    var go = "0"
    var  map : JSON = []
    var map2 : JSON = []
    var map3 : JSON = []
    var userinfo : JSON = []
    var key = String()
    
    var urlString = "http://twpetanimal.ddns.net:9487/api/v1/maps?$filter=mapType%20eq%20%27%E5%8B%95%E7%89%A9%E9%86%AB%E9%99%A2%27"
    
    var url2 = "http://twpetanimal.ddns.net:9487/api/v1/maps?$filter=mapType%20eq%20%27%E5%90%88%E6%A0%BC%E5%AF%B5%E7%89%A9%E6%A5%AD%E8%80%85%27"
    
    var url3 = "http://twpetanimal.ddns.net:9487/api/v1/maps?$filter=mapType%20eq%20%27%E7%8B%82%E7%8A%AC%E7%97%85%E6%B3%A8%E5%B0%84%E7%AB%99%27"
    override func viewDidLoad() {
        super.viewDidLoad()
        go = "0"
       downloadJsonWithURL()
        downloadJsonWithURL2()
        downloadJsonWithURL3()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func downloadJsonWithURL() {
        
        
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSString) != nil {
                
                
                let jsonaimal = JSON(data : data!)
                
                self.map = jsonaimal
               
            
               
            }
        }).resume()
    }
    
    func downloadJsonWithURL2() {
        
        
        
        let url = NSURL(string: url2)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSString) != nil {
                
                
                let jsonaimal = JSON(data : data!)
                
                self.map2 = jsonaimal
                
                
            }
        }).resume()
    }
    
    
    func downloadJsonWithURL3() {
        
        
        
        let url = NSURL(string: url3)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSString) != nil {
                
                
                let jsonaimal = JSON(data : data!)
                
                self.map3 = jsonaimal
                
                
            }
        }).resume()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backmenu"){
        
            let destinationController = segue.destination as! IndexViewController
            
            destinationController.token = self.userinfo
            destinationController.key = self.key
        
        }
        
        if(segue.identifier == "sendhospital"){
            
            if(go == "1")
            {
                print("go1")
            let destinationController = segue.destination as! HospitalMapViewController
            destinationController.map = self.map
                destinationController.userinfo = self.userinfo
                destinationController.key = self.key
            }
            if(go == "2")
            {
                print("go2")
                let destinationController = segue.destination as! HospitalMapViewController
                destinationController.map = self.map2
                destinationController.userinfo = self.userinfo
                destinationController.key = self.key
            }
            if(go == "3")
            {
                print("go3")
                let destinationController = segue.destination as! HospitalMapViewController
                destinationController.map = self.map3
                destinationController.userinfo = self.userinfo
                destinationController.key = self.key
            }
            
            
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
    @IBAction func BTN1(_ sender: Any) {
        go = "1"
    }

    @IBAction func BTN(_ sender: Any) {
         go = "2"
    }
 
    @IBAction func Btn3(_ sender: Any) {
        go = "3"
    }
}
