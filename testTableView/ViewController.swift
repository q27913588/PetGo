//
//  ViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/1/8.
//  Copyright © 2017年 謝樹瑄. All rights reserved.

import UIKit
import ESPullToRefresh
import NVActivityIndicatorView

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

     var urlString = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=10&$skip=0"
  
   
    var userinfo : JSON = []
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    var test1 : String = "1234"
    var nameArray = [String]()
    var dobArray = [String]()
    var imgURLArray = [String]()
    var maparray = [String]()
    var color = [String]()
    var phone = [String]()
    var adress = [String]()
    var skip : Int = 10
    let activityData = ActivityData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!.replacingOccurrences(of: "%22", with: "").replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: ""))
        self.downloadJsonWithURL()
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self?.nameArray.removeAll()
            self?.tableView.reloadData()
             self?.downloadJsonWithURL()
            /// 在这里做刷新相关事件
            /// ...
            /// 如果你的刷新事件成功，设置completion自动重置footer的状态
           self?.tableView.es_stopPullToRefresh(ignoreDate: true)
            /// 设置ignoreFooter来处理不需要显示footer的情况
            self?.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
        
     
        self.tableView.es_addInfiniteScrolling {
            [weak self] in
            
            self?.urlString = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=10&$skip=\(self!.skip)"
            self?.downloadJsonWithURL()
            self?.tableView.es_stopLoadingMore()
            //self?.tableView.es_noticeNoMoreData()
            self?.skip += 10
            print(self!.skip)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
                                
                for animal in 0..<jsonaimal.count
                {
                    if let name = jsonaimal[animal]["animal_kind"].string {
                        self.nameArray.append(name)
                    }
                    if let name = jsonaimal[animal]["animal_sex"].string {
                        self.dobArray.append(name)
                    }
                    
                    if let name = jsonaimal[animal]["animal_colour"].string {
                        self.color.append(name)
                    }
                    if let name = jsonaimal[animal]["animal_place"].string {
                        self.adress.append(name)
                    }
                    if let name = jsonaimal[animal]["shelter_tel"].string {
                        self.phone.append(name)
                    }
                    if let name = jsonaimal[animal]["album_file"].string {
                                self.imgURLArray.append(name)
                    }
                    if let name = jsonaimal[animal]["shelter_address"].string {
                        self.maparray.append(name)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell

        cell.namelabel.text = nameArray[indexPath.row]
        cell.doblable.text = dobArray[indexPath.row]
        cell.Textcolor.text = color[indexPath.row]
        let imgURL = NSURL(string: imgURLArray[indexPath.row])

            if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
                
                if data != nil{
                 cell.ImageView.image = UIImage(data: data as! Data)
                }else{
            cell.ImageView.image = UIImage(named:"nodogimages")
        }
        }
        return cell
    }
    
    
       func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler:
            {(action,indexPath) -> Void in
                
                let defaulText = "test"
                
               
                
                
                let imgURL = NSURL(string: self.imgURLArray[indexPath.row])
                var shareimg = UIImage()
                if imgURL != nil {
                    let data = NSData(contentsOf: (imgURL as? URL)!)
                    
                    if data != nil{
                        shareimg = UIImage(data: data as! Data)!
                    }else{
                         shareimg = UIImage(named:"nodogimages")!
                    }
                }
                let activityController = UIActivityViewController(activityItems: [defaulText,shareimg], applicationActivities: nil)
                
                self.present(activityController, animated: true, completion:nil)})
        
                shareAction.backgroundColor = UIColor.green

        
        
        return [shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "showAnimalDetail"{
        let destinationController = segue.destination as!AnimalViewController
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
                destinationController.adress = self.adress[tableView.indexPathForSelectedRow!.row]
                destinationController.phone = self.phone[tableView.indexPathForSelectedRow!.row]
                destinationController.color = self.color[tableView.indexPathForSelectedRow!.row]
            destinationController.type = self.nameArray[tableView.indexPathForSelectedRow!.row]
            destinationController.sex = self.dobArray[tableView.indexPathForSelectedRow!.row]
            
                destinationController.AnimalImageview = shareimg
                destinationController.Animalmap = self.maparray[tableView.indexPathForSelectedRow!.row]
            }
       
        if(segue.identifier == "backindex"){
            
            
            
            let destinationController = segue.destination as! IndexViewController
            destinationController.token = self.userinfo
            
        }
            
        
    }
    

    }
    
  





