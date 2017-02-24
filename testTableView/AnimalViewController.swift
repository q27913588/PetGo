//
//  AnimalViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/1/20.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class AnimalViewController: UIViewController {
    @IBOutlet weak var texttpye: UILabel!

    @IBOutlet weak var textsex: UILabel!
    
    @IBOutlet weak var textcolor: UILabel!
    @IBOutlet weak var AnimalImage: UIImageView!
 
    @IBOutlet weak var textadress: UILabel!
    @IBOutlet weak var textphone: UILabel!
    var AnimalImageview = UIImage()
    var Animalmap = String()
    var adress = String()
    var phone = String()
    var sex = String()
    var type = String()
    var color = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        textsex.text = sex
        texttpye.text = type
        textcolor.text = color
        textphone.text = phone
        textadress.text = adress
        
        
        AnimalImage.image = AnimalImageview
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SendMap"){
            
            
            let destinationController = segue.destination as! MapViewController
            destinationController.Animalmap = self.Animalmap
            
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
