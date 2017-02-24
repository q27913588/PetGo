//
//  HospitalMapViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/16.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HospitalMapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    @IBOutlet weak var mapview: MKMapView!
    let locationManager = CLLocationManager()
  var map : JSON = []
    var userinfo : JSON = []
    var key = String()

    var urlString = "http://twpetanimal.ddns.net:9487/api/v1/maps?$filter=mapType%20eq%20%27%E5%8B%95%E7%89%A9%E9%86%AB%E9%99%A2%27"
    
     var myLocationManager :CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        point()
        // 2. 配置 locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
       
        // 3. 配置 mapView
        mapview.delegate = self
        mapview.showsUserLocation = true
        mapview.userTrackingMode = .follow
          locationManager.startUpdatingLocation();

    point()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1. 還沒有詢問過用戶以獲得權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. 用戶不同意
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. 用戶已經同意
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    func point (){
        
        for count in 0..<self.map.count
        {
            
            if(self.map[count]["maplatitude"].string == nil )
            {
                self.map[count]["maplatitude"] = 0.0
            }
            if(self.map[count]["maplongitude"].string == nil )
            {
                self.map[count]["maplongitude"] = 0.0
            }
            
            if(self.map[count]["mapName"].string == nil)
            {
                self.map[count]["mapName"].string = "無"
            }
            
            if(self.map[count]["mapAddressCity"].string == nil)
            {
                self.map[count]["mapAddressCity"].string = "無"
            }
            
            if(self.map[count]["mapAddressTown"].string == nil)
            {
                self.map[count]["mapAddressTown"].string = "無"
            }
            
            if(self.map[count]["mapAddressDetail"].string == nil)
            {
                self.map[count]["mapAddressDetail"].string = "無"
            }
            let objectAnnotation = MKPointAnnotation()
            let x = self.map[count]["maplatitude"].string
            let y = self.map[count]["maplongitude"].string
            let x1 = Double(x!)
            let y1 = Double(y!)
            
            objectAnnotation.coordinate = CLLocation(
                latitude: x1!,
                longitude: y1!).coordinate
            
            objectAnnotation.title = self.map[count]["mapName"].string
            objectAnnotation.subtitle = self.map[count]["mapAddressCity"].string! + self.map[count]["mapAddressTown"].string! + self.map[count]["mapAddressDetail"].string!
            
            
            self.mapview.addAnnotation(objectAnnotation)
            
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //取得目前的座標位置
        let c = locations[0] as! CLLocation;
        //c.coordinate.latitude 目前緯度
        //c.coordinate.longitude 目前經度
        let nowLocation = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude);
        
        //將map中心點定在目前所在的位置
        //span是地圖zoom in, zoom out的級距
        let _span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005);
        self.mapview.setRegion(MKCoordinateRegion(center: nowLocation, span: _span), animated: true);
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backmap"){
            
            let destinationController = segue.destination as! HelpMapViewController
            
            destinationController.userinfo = self.userinfo
            destinationController.key = self.key
            
        }
    }
}
