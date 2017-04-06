//
//  ViewController.swift
//  Forecast
//
//  Created by Maxime BINET on 4/5/17.
//  Copyright © 2017 Maxime BINET. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ForecastIO

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let locationManager = CLLocationManager()
    var tab : [Meteo] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tab.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meteoCell") as! MeteoTableViewCell
        cell.meteo = self.tab[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello");
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleMeteo(meteo: Meteo) {
        self.tab.append(meteo)
        if (self.tab.count > 40) {
            self.build()
        }
    }
    
    func build() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func getWeather( lat: Double, long: Double) {
        let client = DarkSkyClient(apiKey: "ca559473d89ce229c5f07067b42730c8")
        client.units = .si
        client.getForecast(latitude: lat, longitude: long) { result in
            switch result {
            case .success(let currentForecast, _):
                let hourly = currentForecast.hourly!
                for p in hourly.data {
                    let hour = Calendar.current.component(.hour, from: p.time)
                    print("\(hour)h  |  \(p.temperature!)  |  \(p.icon!.rawValue)")
                    let meteo = Meteo(h: String(hour), t: String(describing: Int(p.temperature!)), i: p.icon!.rawValue)
                    self.handleMeteo(meteo: meteo)
                }
            case .failure(let error):
                print("couldnt get forecast : \(error)")
            }
        }
    }
    
    // Users location management
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myLat = location.coordinate.latitude
        let myLong = location.coordinate.longitude
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLong)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
        getWeather(lat: myLat, long: myLong)
        
        self.map.showsUserLocation = true
    }
    
    func locationManager(didFailWithError error: NSError) {
        print("location error")
    }

}

