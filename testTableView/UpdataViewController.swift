//
//  UpdataViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/4.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class UpdataViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var postUrl =  "https://api.imgur.com/3/upload/"
    var check = ""
       var postUrlA = "http://twpetanimal.ddns.net:9487/api/v1/animalDatas"
    let imgurClientId = "ca1f314fb14a531"
    let mashapeKey = "QRf1Whm1CFmshBbTThsQ1oQdNbfKp12tJ5ojsnKeynLHuWTth0";     
   var animal : JSON = [] 
    var imgurl : String = ""
    var key = String()
    var userinfo : JSON = []
    
    @IBAction func Btntackphoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.allowsEditing = true  // 允许拍摄图片后编辑
            self.present(picker, animated: true, completion: nil)
        } else {
            print("can't find camera")
        }
    }
    
    
    @IBAction func SetImgLibiry(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
    }
    
    
   


    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("didFinishPickingImage")
        
        self.imageView.image = image // 保存拍摄（编辑）后的图片到我们的imageView展示
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil) // 将图片保存到相册
        picker.dismiss(animated: true, completion: nil) // 退出相机界面
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        picker.dismiss(animated: true, completion: nil) // 退出相机界面
    }
    
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    func uploadIMG()
    {
       /* let alert = UIAlertController(title: nil, message: "圖片上傳中....", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)*/
        //-------------動畫
        let upImg =  UIImagePNGRepresentation(imageView.image!) as NSData?
        
        let base64String = upImg?.base64EncodedString()
        let img : JSON =
            [
                "image"    : base64String!,
                "title" : "test",
                ]
        let url:NSURL = NSURL(string: postUrl)!;
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 5);
        /*  request.addValue(mashapeKey, forHTTPHeaderField: "X-Mashape-Key")*/
        request.addValue("Client-ID "+imgurClientId, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST";
        request.httpBody = try! img.rawData()
        
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
            let imgjson = JSON(data : data!)
            if let name = imgjson["data"]["link"].string {
                self.imgurl = name
                print(name)
            }
            
            
   
            print(imgjson["data"]["link"])
            print(self.imgurl)
            self.animal["animalData_Pic"][0]["animalPicAddress"].string = self.imgurl
           
            self.uptoSQLJson()
            
        }
        task.resume();
        //------停止
        
        let alertController = UIAlertController(
            title: "提示",
            message: "上傳完成",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                self.performSegue(withIdentifier: "uploadOK", sender: self)
                
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
        

        //------停止
        
    }
    
    func uptoSQLJson()
    {
        let url:NSURL = NSURL(string: self.postUrlA)!;
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer "+self.key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST";
        request.httpBody = try! self.animal.rawData()
        
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
            
            //動畫停止
            /*  self.dismiss(animated: false, completion: nil)*/
            //動畫停止
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
        }
        task.resume();
    }
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       
            if(segue.identifier == "uploadOK"){
                let destinationController = segue.destination as! IndexViewController
                destinationController.token = self.userinfo
               destinationController.key = self.key
              
            }
        }
   
    @IBAction func Btnupload(_ sender: Any) {
        if(self.imageView.image == nil)
        {
            alert(message: "請先選擇圖片")
        }
        else
        {
            uploadIMG()
        

        }
    }
}

    
    
    


