//
//  MapViewController.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/7.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var Animalmap = String()
var location : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        map.isZoomEnabled = true
        
        location = CLLocationManager();
        location.delegate = self;
        
        //詢問使用者是否同意給APP定位功能
        location.requestWhenInUseAuthorization();
        //開始接收目前位置資訊
        location.startUpdatingLocation();
        
        var chooseCoordinates = CLLocationCoordinate2D()
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan =
            MKCoordinateSpanMake(latDelta, longDelta)
        let geocoder = CLGeocoder()

        
        
        geocoder.geocodeAddressString(Animalmap) { placemarks, error in
            if error != nil {
                print(error!)
            }
            
            if let placemark = placemarks?.first {
                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                chooseCoordinates = coordinates
                let currentRegion:MKCoordinateRegion =
                    MKCoordinateRegion(
                        center: chooseCoordinates,
                        span: currentLocationSpan)
                self.map.setRegion(currentRegion, animated: true)
                
                    let point:MKPointAnnotation = MKPointAnnotation();
                    //設定大頭針的座標位置
                    point.coordinate = chooseCoordinates
                    point.title = self.Animalmap;
                
                    
                    self.map.addAnnotation(point);
                

                // call the method that uses `chooseCoordinates` here
            }
        }
        
        
        // 設置地圖顯示的範圍與中心點座標
        
    /*
        let center:CLLocation = CLLocation(
            latitude: 25.05, longitude: 121.515)
        let currentRegion:MKCoordinateRegion =
            MKCoordinateRegion(
                center: chooseCoordinates,
                span: currentLocationSpan)
        map.setRegion(currentRegion, animated: true)
        
  */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.map.setRegion(MKCoordinateRegion(center: nowLocation, span: _span), animated: true);
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


