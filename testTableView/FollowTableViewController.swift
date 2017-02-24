//
//  FollowTableViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/16.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
class FollowTableViewController: UITableViewController {
  var key = String()
     var userinfo : JSON = []
    var urlString = "http://twpetanimal.ddns.net:9487/api/v1/followAnis/0cee9178-0b2d-42e9-859d-cf061e4750f3"
    
    let activityData = ActivityData()
    var animalDate = [String]()

   
      var nameArray = [String]()
    var dobArray = [String]()
    var imgURLArray = [String]()
    var animaltype = [String]()
    var animalcolor = [String]()
    var health = [String]()
    var detail = [String]()
    var sex = [String]()
    var userid = [String]()
    var animalID = [Int]()
      var animalAge = [Int]()

    override func viewDidLoad() {
        urlString = "http://twpetanimal.ddns.net:9487/api/v1/followAnis/\(userinfo["UserId"])"
        
        super.viewDidLoad()
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

    
    func downloadJsonWithURL() {
        
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!.replacingOccurrences(of: "%22", with: "").replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: ""))
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSString) != nil {
                
                
                let jsonaimal = JSON(data : data!)
                print(jsonaimal.count)
                print(jsonaimal.count)
                print(jsonaimal[0]["animalPicAddress"].string as Any )
                
                for animal in 0..<jsonaimal.count
                {
                    if let name = jsonaimal[animal]["animalAge"].int
                    {
                        self.animalAge.append(name)
                    }
                    
                    if let name = jsonaimal[animal]["animalAddress"].string {
                        self.nameArray.append(name)
                        
                    }
                    if let name = jsonaimal[animal]["animalOwner_userID"].string {
                        self.userid.append(name)
                        
                    }
                    
                    if let name = jsonaimal[animal]["animalName"].string {
                        self.dobArray.append(name)
                    }
                    if let name = jsonaimal[animal]["animalGender"].string {
                        self.sex.append(name)
                    }
                    
                    if let name = jsonaimal[animal]["animalPicAddress"].string {
                        self.imgURLArray.append(name)
                    }
                    if let name = jsonaimal[animal]["animalType"].string {
                        self.animaltype.append(name)
                    }
                    if let name = jsonaimal[animal]["animalColor"].string {
                        self.animalcolor.append(name)
                    }
                    if let name = jsonaimal[animal]["animalHealthy"].string {
                        self.health.append(name)
                    }
                    if let name = jsonaimal[animal]["animalNote"].string {
                        self.detail.append(name)
                    }
                    if let name = jsonaimal[animal]["animalID"].int {
                        self.animalID.append(name)
                    }
                    if let name = jsonaimal[animal]["animalDate"].string {
                        self.animalDate.append(name)
                    }
                    
                    
                }
                
                OperationQueue.main.addOperation({
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    
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
    
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FoloowTableViewCell
    
        cell.TextName.text = self.dobArray[indexPath.row]
        cell.TextAge.text = String(self.animalAge[indexPath.row])
        cell.TextSex.text = self.sex[indexPath.row]
        
        
        
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            
            if data != nil{
                let resource = ImageResource(downloadURL: imgURL as! URL, cacheKey: nil)
                cell.animalIMG.kf.indicatorType = .activity
                cell.animalIMG.kf.setImage(with: resource)
            }else{
                cell.animalIMG.image = UIImage(named:"nodogimages")
            }
        }
        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ShowAnimalDetailTwo"{
            let destinationController = segue.destination as!SelfAnimalViewController
            let imgURL = NSURL(string: self.imgURLArray[tableView.indexPathForSelectedRow!.row])
            var shareimg = UIImage()
            if imgURL != nil {
                let data = NSData(contentsOf: (imgURL as? URL)!)
                
                if data != nil{
                    shareimg = UIImage(data: data as! Data)!
                }else{
                    shareimg = UIImage(named:"nodogimages")!
                }
            }
            destinationController.AnimalImageview = shareimg
            destinationController.animalcolor = self.animalcolor[tableView.indexPathForSelectedRow!.row]
            
            destinationController.animalsex = self.sex[tableView.indexPathForSelectedRow!.row]
              destinationController.animaladress = self.nameArray[tableView.indexPathForSelectedRow!.row]
            destinationController.animalname = self.dobArray[tableView.indexPathForSelectedRow!.row]
            destinationController.animaltype = self.animaltype[tableView.indexPathForSelectedRow!.row]
        
            destinationController.animalID = self.animalID[tableView.indexPathForSelectedRow!.row]
            destinationController.userid = self.userid[tableView.indexPathForSelectedRow!.row]
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
        }
        
        
        
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
