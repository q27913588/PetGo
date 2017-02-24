//
//  SearchViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/1/26.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var SearchUrl : String = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=10&$skip=0&$filter="
  
    @IBAction func BtnCheck(_ sender: Any) {
        if(TextArea.text == "全部")
        {
         SearchUrl += ""
        }
        if(TextArea.text != "全部")
        {
          SearchUrl += "animal_place+like+\(TextArea.text)"
        }
        if(TextAge.text != "全部" )
        {
        SearchUrl += "+and+animal_age+like+\(TextAge.text)"
        }
        if(TextColor.text != "全部")
        {
            SearchUrl += "+and+animal_colour+like+\(TextColor.text)"
            
        }
        if(TextSex.text != "全部")
        {
            SearchUrl += "+and+animal_sex+like+\(TextSex.text)"
            
        }
    
        
    }
 
    @IBOutlet weak var TextColor: UITextField!
   
    @IBOutlet weak var TextAge: UITextField!
    @IBOutlet weak var TextSex: UITextField!
    @IBOutlet weak var TextArea: UITextField!
    var Searchurl : String = "text21"
    let area = ["全部","高雄","嘉義","台中","台北","宜蘭","花蓮"]
    let sex = ["全部","F","M"]
    let color = ["全部","黑","白"]
    let age = ["全部","CHILD"]
    
    
    
   var Mypicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Mypicker.delegate = self
        Mypicker.dataSource = self
        TextArea.text = area[0]
        TextSex.text = sex[0]
        TextColor.text = color[0]
        TextAge.text = age[0]
       TextArea.inputView = Mypicker
        TextAge.inputView = Mypicker
        TextSex.inputView = Mypicker
        TextColor.inputView = Mypicker
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var RE : Int = 0
        if(TextArea.isEditing == true)
        {
        RE = area.count
        }else if(TextSex.isEditing == true)
        {
            RE = sex.count
        }else if(TextColor.isEditing == true)
        {
            RE = color.count
        }else if(TextAge.isEditing == true)
        {
            RE = age.count
        }
        
        
        return RE
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var RE : String = ""
        if(TextArea.isEditing == true)
        {
            RE = area[row]
        }else if(TextSex.isEditing == true)
        {
            RE = sex[row]
        }else if(TextColor.isEditing == true)
        {
            RE = color[row]
        }else if(TextAge.isEditing == true)
        {
            RE = age[row]
        }
        
        
        return RE
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
        if(TextArea.isEditing == true)
        {
            TextArea.text = area[row]
            self.view.endEditing(true)
        }else if(TextSex.isEditing == true)
        {
            TextSex.text = sex[row]
            self.view.endEditing(true)
        }else if(TextColor.isEditing == true)
        {
            TextColor.text = color[row]
            self.view.endEditing(true)
        }else if(TextAge.isEditing == true)
        {
            TextAge.text = age[row]
            self.view.endEditing(true)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowSearch"){
            
            
            let nav = segue.destination as! UINavigationController
            let destinationController = nav.topViewController as! ViewController
            destinationController.urlString = SearchUrl
            
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


}
