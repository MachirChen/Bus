//
//  BusStopMapViewController.swift
//  Bus
//
//  Created by Machir on 2022/9/9.
//

import UIKit
import MapKit
import Geohash

class BusStopMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var busStopAnnotations: [MKPointAnnotation] = []
    var locationManager = CLLocationManager()
    var busStopData = [BusStopResponse]()
    var targetCoordinate = CLLocationCoordinate2D()
    var busStopApiUrlStr = ""
    var button = MKUserTrackingButton()
    
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setBusStopApiUrl()
        MenuController.shared.fetchBusStopData(urlStr: self.busStopApiUrlStr) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let busStopData):
                    self.busStopData = busStopData
                    for i in 0..<busStopData.count {
                        let pointAnnotation = MKPointAnnotation()
                        pointAnnotation.title = busStopData[i].StopName.Zh_tw
                        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(busStopData[i].StopPosition.PositionLat), longitude: Double(busStopData[i].StopPosition.PositionLon))
                        pointAnnotation.subtitle = busStopData[i].StopAddress

                        self.busStopAnnotations.append(pointAnnotation)
                    }
                    print(self.busStopData)
                    self.myMapView.addAnnotations(self.busStopAnnotations)
                case .failure(let error):
                    print("fetchData()-\(error)")
                }
            }
        }
        setupLocationButton()
        setLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func setupLocationButton() {
        let fullScreenSize = UIScreen.main.bounds
        button.mapView = myMapView
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.center = CGPoint(x: fullScreenSize.width * 0.9, y: fullScreenSize.height * 0.75)
        myMapView.addSubview(button)
    }
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(checkDetail), for: .touchUpInside)
        
        annotationView?.glyphImage = UIImage(systemName: "bus")
        annotationView?.canShowCallout = true
        annotationView?.titleVisibility = .adaptive
        annotationView?.subtitleVisibility = .hidden
        annotationView?.markerTintColor = .systemBrown
        annotationView?.rightCalloutAccessoryView = button
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.targetCoordinate = view.annotation!.coordinate
        }
    }
    
    func navigation() {
        let targetPlacemark = MKPlacemark(coordinate: targetCoordinate)
        let targetItem = MKMapItem(placemark: targetPlacemark)
        let userMapItem = MKMapItem.forCurrentLocation()
        let routes = [userMapItem, targetItem]
        
        MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    @objc func checkDetail() {
        let alert = UIAlertController(title: "選擇功能", message: nil, preferredStyle: .actionSheet)
        let options = ["導航"]

        for title in options {
            let action = UIAlertAction(title: title, style: .default) { _ in
                switch title {
                case "導航":
                    self.navigation()
                default:
                    break
                }
            }
            alert.addAction(action)
        }
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func setBusStopApiUrl() {
        if let location = self.locationManager.location?.coordinate {
            self.busStopApiUrlStr = "https://tdx.transportdata.tw/api/advanced/v2/Bus/Stop/NearBy?%24spatialFilter=nearby%28\(location.latitude)%2C%20\(location.longitude)%2C%201000%29&%24format=JSON"
            print(self.busStopApiUrlStr)
        }
    }
    
    //利用GeoHash抓取九宮格位置(參考用)
    func setGeoHash() {
        //抓geoHash
        let currentLocationGeoHash = Geohash.encode(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude, length: 6)
        print(currentLocationGeoHash)
        
        let encodeLatLon = CLLocationCoordinate2D(geohash: currentLocationGeoHash)
        print((encodeLatLon.latitude, encodeLatLon.longitude))
        
        if let (lat, lon) = Geohash.decode(hash: currentLocationGeoHash) {
            print(lat.self)
            let upperLeft = (latitude: (encodeLatLon.latitude + (lat.max - lat.min)), longitude: (encodeLatLon.longitude - (lon.max - lon.min)))
            let upperMiddle = (latitude: (encodeLatLon.latitude + (lat.max - lat.min)), longitude: (encodeLatLon.longitude))
            let upperRight = (latitude: (encodeLatLon.latitude + (lat.max - lat.min)), longitude: (encodeLatLon.longitude + (lon.max - lon.min)))
            let middleLeft = (latitude: (encodeLatLon.latitude), longitude: (encodeLatLon.longitude - (lon.max - lon.min)))
            let middleRight = (latitude: (encodeLatLon.latitude), longitude: (encodeLatLon.longitude + (lon.max - lon.min)))
            let lowerLeft = (latitude: (encodeLatLon.latitude - (lat.max - lat.min)), longitude: (encodeLatLon.longitude - (lon.max - lon.min)))
            let lowerMiddle = (latitude: (encodeLatLon.latitude - (lat.max - lat.min)), longitude: (encodeLatLon.longitude))
            let lowerRight = (latitude: (encodeLatLon.latitude - (lat.max - lat.min)), longitude: (encodeLatLon.longitude + (lon.max - lon.min)))
            
            let encodeUpperLeft = Geohash.encode(latitude: upperLeft.latitude, longitude: upperLeft.longitude, length: 6)
            print(encodeUpperLeft)
            let encodeUpperMiddle = Geohash.encode(latitude: upperMiddle.latitude, longitude: upperMiddle.longitude, length: 6)
            print(encodeUpperMiddle)
            let encodeUpperRight = Geohash.encode(latitude: upperRight.latitude, longitude: upperRight.longitude, length: 6)
            print(encodeUpperRight)
            let encodeMiddleLeft = Geohash.encode(latitude: middleLeft.latitude, longitude: middleLeft.longitude, length: 6)
            print(encodeMiddleLeft)
            let encodeMiddleRight = Geohash.encode(latitude: middleRight.latitude, longitude: middleRight.longitude, length: 6)
            print(encodeMiddleRight)
            let encodeLowerLeft = Geohash.encode(latitude: lowerLeft.latitude, longitude: lowerLeft.longitude, length: 6)
            print(encodeLowerLeft)
            let encodeLowerMiddle = Geohash.encode(latitude: lowerMiddle.latitude, longitude: lowerMiddle.longitude, length: 6)
            print(encodeLowerMiddle)
            let encodeLowerRight = Geohash.encode(latitude: lowerRight.latitude, longitude: lowerRight.longitude, length: 6)
            print(encodeLowerRight)
            
            let url = "https://tdx.transportdata.tw/api/basic/v2/Bus/Stop/City/YunlinCounty?%24filter=startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeUpperLeft)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeUpperMiddle)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeUpperRight)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeMiddleLeft)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeMiddleRight)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeLowerLeft)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeLowerMiddle)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(encodeLowerRight)%27%29%20or%20startswith%28StopPosition%2FGeoHash%2C%20%27\(currentLocationGeoHash)%27%29&%24format=JSON"
            self.busStopApiUrlStr = url
            print(busStopApiUrlStr)
        }
    }
    
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        switch locationManager.authorizationStatus {
        case .denied:
            let alert = UIAlertController(title: "定位權限已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確認", style: .default))
            self.present(alert, animated: true)
        case .authorizedWhenInUse:
            DispatchQueue.main.async {
                if let location = self.locationManager.location?.coordinate {
                    let currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    self.myMapView.setRegion(currentRegion, animated: true)
                    print(currentRegion)
                } else {
                    print("無法定位使用者位置(BusStopMapViewController)")
                }
            }
        default:
            break
        }
        myMapView.delegate = self
        myMapView.showsUserLocation = true
        myMapView.userTrackingMode = .follow
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[locations.count - 1] as CLLocation
        
        if currentLocation.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("\(currentLocation.coordinate.latitude)")
            print(", \(currentLocation.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("func locationManager-\(error)")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
