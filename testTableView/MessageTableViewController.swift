//
//  MessageTableViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/12.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class MessageTableViewController: UITableViewController {
var urlString = "http://twpetanimal.ddns.net:9487/api/v1/MsgUsers/"
    var userinfo : JSON = []
    var type = ""
    var key = String()
    var name = [String]()
    var msgid = [String]()
    var time = [String]()
    var info = [String]()
    var msg = [String]()
    var msgtype = [String]()
    var msgjason : JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        urlString = "http://twpetanimal.ddns.net:9487/api/v1/MsgUsers/\(userinfo["UserId"].string)"
        print(userinfo["UserId"])
    
      self.downloadJsonWithURL()
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

    func downloadJsonWithURL() {
        
        
        
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!.replacingOccurrences(of: "%22", with: "").replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: ""))
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSString) != nil {
                
                
                let jsonaimal = JSON(data : data!)
               
                self.msgjason = jsonaimal
                for animal in 0..<jsonaimal.count
                {
                    if let name = jsonaimal[animal]["msgFrom_userName"].string {
                        self.name.append(name)
                    }
                    
                    if let name = jsonaimal[animal]["msgTime"].string {
                        self.time.append(name)
                    }
                    if let name = jsonaimal[animal]["msgRead"].string {
                    
                        self.info.append(name)
                    }
                    if let name = jsonaimal[animal]["msgContent"].string {
                        
                        self.msg.append(name)
                    }
                    if let name = jsonaimal[animal]["msgID"].string {
                        
                        self.msgid.append(name)
                    }
                    if let name = jsonaimal[animal]["msgType"].string {
                        
                        self.msgtype.append(name)
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell3
        
        cell.Texttype.text = msgtype[indexPath.row]
        cell.Textname.text = name[indexPath.row]
        cell.TextTime.text = time[indexPath.row]
        cell.TextInfo.text = info[indexPath.row]
       
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let alertController = UIAlertController(
            title: "訊息",
            message: msg[indexPath.row],
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                
        })
        alertController.addAction(okAction)
        self.present(
            alertController,
            animated: true,
            completion: nil)
        
        let id = msgjason[indexPath.row]["msgID"]
        print("msgid:\(msgjason[indexPath.row]["msgID"])")
    
        msgjason[indexPath.row]["msgRead"].string = "已讀"
        let url:NSURL = NSURL(string: "http://twpetanimal.ddns.net:9487/api/v1/MsgUsers/\(id)")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "PUT";
        request.httpBody = try! msgjason[indexPath.row].rawData()
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
  
    }
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler:  {
            (action: UIAlertAction!) -> Void in
            self.name.removeAll()
            self.downloadJsonWithURL()
         self.tableView.reloadData()
            
        })
        
       if(type == "repo")
       {
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "訊息"
        }
        }
        let reportAction = UIAlertAction(title: "回覆", style: .default, handler:  {
            (action: UIAlertAction!) -> Void in
            let remsg =
                (alertController.textFields?.first)!
                    as UITextField
            self.name.removeAll()
            self.downloadJsonWithURL()
            self.tableView.reloadData()
            
        })
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        
        if(type == "OK")
        {
        alertController.addAction(OKAction)
        }else if(type == "repo")
        {
            alertController.addAction(cancelAction)
             alertController.addAction(reportAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "刪除", handler:
            {(action,indexPath) -> Void in
                let id = self.msgjason[indexPath.row]["msgID"]
                print("msgid:\(self.msgjason[indexPath.row]["msgID"])")
                
                               let url:NSURL = NSURL(string: "http://twpetanimal.ddns.net:9487/api/v1/MsgUsers/\(id)")!
            ;
                let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("Bearer "+self.key, forHTTPHeaderField: "Authorization")
                request.httpMethod = "DELETE";
                request.httpBody = try! self.msgjason[indexPath.row].rawData()
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
                self.type = "OK"
              self.alert(message: "刪除成功")
        })
        
        let report = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "回覆", handler:
            {(action,indexPath) -> Void in
                self.type = "repo"
                self.alert(message: "回覆")
        
        })
            self.type = ""
            
        shareAction.backgroundColor = UIColor.red
        report.backgroundColor = UIColor.gray
        return [shareAction,report]
        
        
    }

    @IBAction func Btnsearch(_ sender: Any) {
        let alertController = UIAlertController(title: "收尋", message: "請選擇信件類型", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "留言板通知", style: UIAlertActionStyle.default)
        {
            
            (result : UIAlertAction) -> Void in
            self.name.removeAll()
            print("?$filter=msgType%20eq%20%27訊息回覆%27")
           let newurl = self.urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!.replacingOccurrences(of: "%22", with: "").replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            let trueurl = newurl+"?$filter=msgType%20eq%20%27訊息回覆%27"
            print(trueurl)
            let url = NSURL(string: trueurl)
            
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url as! URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 5);
            /*  request.addValue(mashapeKey, forHTTPHeaderField: "X-Mashape-Key")*/
         
            
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
                // self.dismiss(animated: false, completion: nil )
                
                
                let jsonaimal = JSON(data : data!)
                
                self.msgjason = jsonaimal
                for animal in 0..<jsonaimal.count
                {
                    if let name = jsonaimal[animal]["msgFrom_userName"].string {
                        self.name.append(name)
                    }
                    
                    if let name = jsonaimal[animal]["msgTime"].string {
                        self.time.append(name)
                    }
                    if let name = jsonaimal[animal]["msgRead"].string {
                        
                        self.info.append(name)
                    }
                    if let name = jsonaimal[animal]["msgContent"].string {
                        
                        self.msg.append(name)
                    }
                    if let name = jsonaimal[animal]["msgID"].string {
                        
                        self.msgid.append(name)
                    }
                    if let name = jsonaimal[animal]["msgType"].string {
                        
                        self.msgtype.append(name)
                    }
                    
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
            task.resume();
        }
        let okAction2 = UIAlertAction(title: "認養通知", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
        }
        let okAction3 = UIAlertAction(title: "訊息回覆", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
        }
        let okAction4 = UIAlertAction(title: "站內信", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
        }
        let okAction5 = UIAlertAction(title: "取消", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
        }
        
        
        alertController.addAction(okAction)
        alertController.addAction(okAction2)
        alertController.addAction(okAction3)
        alertController.addAction(okAction4)
        alertController.addAction(okAction5)
        
        
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
