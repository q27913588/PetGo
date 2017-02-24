//
//  BoradTableViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/13.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class BoradTableViewController: UITableViewController {
    var boradID = Int()
    
    
var urlString = "http://twpetanimal.ddns.net:9487/api/v1/boards?$filter=board_animalID eq"
      var msgjason : JSON = []
    var key = String()
        var name = [String]()
        var time = [String]()
        var detail = [String]()
    var userinfo : JSON = []
    
    
    override func viewDidLoad() {
        self.name.removeAll()
        super.viewDidLoad()
         urlString = "http://twpetanimal.ddns.net:9487/api/v1/boards?$filter=board_animalID eq \(boradID)"
downloadJsonWithURL()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoradTableViewCell
        
        cell.TextName.text = name[indexPath.row]
        cell.TextTime.text = time[indexPath.row]
        cell.TextDetail.text = detail[indexPath.row]
        return cell
    }
    func downloadJsonWithURL() {
        
        
        
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!.replacingOccurrences(of: "%22", with: "").replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: ""))
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSString) != nil {
                
                
                let jsonaimal = JSON(data : data!)
                
                self.msgjason = jsonaimal
                for animal in 0..<jsonaimal.count
                {
                    if let name = jsonaimal[animal]["UserName"].string {
                        self.name.append(name)
                    }
                    
                    if let name = jsonaimal[animal]["boardTime"].string {
                        self.time.append(name)
                    }
                    if let name = jsonaimal[animal]["boardContent"].string {
                        
                        self.detail.append(name)
                    
                }
                }
                OperationQueue.main.addOperation({
                          self.tableView.reloadData()
                })
            }
        }).resume()
    }
    
    
    
    
    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
        }).resume()
    }

    @IBAction func Btnrepor(_ sender: Any) {
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
            
        }else {
        alert(message: "留言")
        
        }

    }
    
    
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
     
  
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "訊息"
            }
        
        let reportAction = UIAlertAction(title: "回覆", style: .default, handler:  {
            (action: UIAlertAction!) -> Void in
            let remsg =
                (alertController.textFields?.first)!
                    as UITextField
            let postjson : JSON = [
            "boardID" : self.boradID,
            "boardTime" : self.msgjason[0]["boardTime"],
                "board_userID" : self.userinfo["UserId"],
                "board_animalID" : self.msgjason[0]["board_animalID"],
                "boardContent" : remsg.text!
            ]
            
            
            
            
            
            self.msgjason[0]["boardID"].int = self.boradID
            self.msgjason[0]["UserName"].string = self.userinfo["Email"].string
               self.msgjason[0]["board_userID"].string = self.userinfo["UserId"].string
            
             self.msgjason[0]["boardContent"].string = remsg.text
            let url:NSURL = NSURL(string: "http://twpetanimal.ddns.net:9487/api/v1/boards")!
            
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer "+self.key, forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST";
            request.httpBody = try! postjson.rawData()
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
                print(postjson)
                
                self.viewDidLoad()

            }
            task.resume()
            
            
        
            
            
            
        })
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(reportAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
