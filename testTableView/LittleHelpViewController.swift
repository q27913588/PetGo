//
//  LittleHelpViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/17.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class LittleHelpViewController: UIViewController {
    var userinfo : JSON = []
    var key = String()
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "http://twpetanimal.ddns.net/Home/Help");
        let requestObj = NSURLRequest(url: url! as URL);
        webview.loadRequest(requestObj as URLRequest);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func BtnUP(_ sender: Any) {
        self.webview.goBack()
        
        
    }

    @IBAction func BtnDown(_ sender: Any) {
        self.webview.goForward()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier  == "backindex"){
            let destinationController = segue.destination as!  IndexViewController
            destinationController.token = self.userinfo
            destinationController.key = self.key
            
        }
    }
}
