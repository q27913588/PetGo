//
//  UpdataAnimalViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/5.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class UpdataAnimalViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
 
   
    @IBAction func send(_ sender: Any) {
        check = "OK"
            performSegue(withIdentifier: "ThrowAnimal", sender: self)
            
        
    }
    @IBAction func sendanimal(_ sender: Any) {
        check = "OK"
        
    }
    
   var check = ""
    let type = ["狗","貓","鼠",]
    let animaltype = ["吉娃娃","柴犬","巴哥"]
    let sex = ["公","母"]
    
    
    @IBOutlet weak var TextSex: UITextField!
    @IBOutlet weak var TextAnother: UITextField!
    @IBOutlet weak var TextColor: UITextField!
    @IBOutlet weak var TextAge: UITextField!
    @IBOutlet weak var TextLocation: UITextField!
    @IBOutlet weak var TextAnimalName: UITextField!
    @IBOutlet weak var TextAnimalType: UITextField!
    @IBOutlet weak var TextType: UITextField!
    var key = String()
    var userinfo : JSON = []
    
    @IBOutlet weak var stackviewOne: NSLayoutConstraint!
    var postUrl = "http://twpetanimal.ddns.net:9487/api/v1/animalDatas"
       var animal : JSON =
        [
            
            "animalID": 0,
            "animalName": "小白IOS",
            "animalAddress": "高雄",
            "animalDate": "20170103",
            "animalGender": "母",
            "animalAge": 3,
            "animalColor": "黃色",
            "animalBirth": "否、沒有生產過",
            "animalChip": "否",
            "animalHealthy": "健康",
            "animalDisease_Other": "已做體內外驅蟲、打過第一劑",
            "animalOwner_userID": 1,
            "animalReason": "愛媽救援的浪浪",
            "animalGetter_userID": 1,
            "animalAdopted": "",
            "animalAdoptedDate": "",
            "animalNote": "需要先收取結紮保證金1000元、結紮後退還。活潑健康、但不喜歡被關籠（關籠會叫）、不挑食、聰明乖巧、學習快。請大家多多幫忙分享，年前送不出去就要原放，希望她別再流浪",
            "animalKind": "狗",
            "animalType": "米克斯",
            "animalData_Pic": [
                [
                    "animalPicID": 1,
                    "animalPic_animalID": 1,
                    "animalPicAddress": "http://i.imgur.com/www"
                ]
            ],
            "animalData_Condition": [
                [
                    "conditionID": 1,
                    "condition_animalID": 1,
                    "conditionAge": "不限",
                    "conditionEconomy": "需有穩定收入",
                    "conditionHome": "不限",
                    "conditionFamily": "不限",
                    "conditionReply": "不限",
                    "conditionPaper": "不限",
                    "conditionFee": "不限",
                    "conditionOther": "不限"
                ],
            ],
            ]
     var Mypicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
       animal["animalOwner_userID"] = userinfo["UserId"]
        Mypicker.delegate = self
        Mypicker.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
      
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(canclePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        TextType.inputView = Mypicker
        TextType.inputAccessoryView = toolBar
        TextSex.inputView = Mypicker
        TextSex.inputAccessoryView = toolBar
        TextAge.inputAccessoryView = toolBar
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
      
        
        if(TextAge.isEditing == true)
        {
        
            self.view.frame.origin.y -= 120
          TextAge.text = ""
        }
        if(TextAnimalName.isEditing == true)
        {
            self.view.frame.origin.y -= 170
        }
        if(TextColor.isEditing == true)
        {
            self.view.frame.origin.y -= 190
        }
        if(TextAnother.isEditing == true)
        {
            self.view.frame.origin.y -= 210
            
        }
    
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.view.frame.origin.y = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ThrowAnimal"){
            
            
            animal["animalName"].string = TextAnimalName.text
            animal["animalAddress"].string  = TextLocation.text
            animal["animalAge"].int  = Int(TextAge.text!)
            animal["animalGender"].string  = TextSex.text
            animal["animalKind"].string  = TextType.text
            animal["animalType"].string  = TextAnimalType.text
            animal["animalColor"].string  = TextColor.text
            animal["animalNote"].string  = TextAnother.text
            print(animal["animalNote"])
            let destinationController = segue.destination as! UpdataViewController
            destinationController.animal = self.animal
            
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
        }
        if(segue.identifier == "backindex"){
            
            
            
            let destinationController = segue.destination as! IndexViewController
            destinationController.token = self.userinfo
            
        }
     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var RE : Int = 0
        if(TextType.isEditing == true)
        {
            RE = type.count
        }
        if(TextSex.isEditing == true)
        {
            RE = sex.count
        }
        
        
        return RE
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var RE : String = ""
        if(TextType.isEditing == true)
        {
            RE = type[row]
        }
        if(TextSex.isEditing == true)
        {
            RE = sex[row]
        }
        
        
        return RE
    }
    
    func donePicker (sender:UIBarButtonItem)
    {
         if(TextType.isEditing == true)
         {
        TextType.text = type[Mypicker.selectedRow(inComponent: 0)]
        TextType.resignFirstResponder()
        }
        if(TextSex.isEditing == true)
        {
            TextSex.text = sex[Mypicker.selectedRow(inComponent: 0)]
            TextSex.resignFirstResponder()
        }
        if(TextAge.isEditing == true)
        {
            self.view.frame.origin.y = 0
            TextAge.resignFirstResponder()
        }

    }
    
    func canclePicker (sender:UIBarButtonItem)
    {
        
        if(TextType.isEditing == true)
        {
        TextType.resignFirstResponder()
        }
        if(TextSex.isEditing == true)
        {
         TextSex.resignFirstResponder()
        }
        if(TextAge.isEditing == true)
        {
            self.view.frame.origin.y = 0
            TextAge.resignFirstResponder()
        }
        
    }
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
   if(identifier == "ThrowAnimal")
        {
            if(self.TextAge.text != "0" && self.TextAnimalName != nil)
            {
                  
                return true
            }
            self.alert(message: "資料尚未填寫完成")
            return false
        }
        return true
    }
}
