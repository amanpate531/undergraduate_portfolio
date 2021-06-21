//
//  Names: Taral Shah, Aman Patel, Vijay Tewari
//  Emails: tarshah@iu.edu, amanpate@iu.edu, vtewari@iu.edu
//  App Name: CityGems
//  Submission Date: May 4, 2021

//  ViewController.swift
//  CityGems
//
//  Created by Vijay  Tewari on 4/18/21.
//

import UIKit
import MapKit
import UserNotifications
import CoreLocation

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // the reference to our AppDelegate:
    var appDelegate: AppDelegate?
    var locationManager: CLLocationManager = CLLocationManager()
    //the reference to our data model:
    var myCityGemsModel: CityGemsModel?
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myCityGemsModel = self.appDelegate?.myCityGemsModel
        // retrieve annotations from model
        let annotations = myCityGemsModel?.getAnnotations()
        self.map.addAnnotations(annotations!)
        // displays user location if they allow access to current location
        self.map.showsUserLocation = true
        // Do any additional setup after loading the view.
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        //print(locationManager.authorizationStatus)
        sendNotification()
    }
    
    // Defines MKAnnotationView to be added to MKMapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Only show annotations that are of type City
        guard annotation is City else { return nil }
        let identifier = "City"
        // Allows for multiple annotations of a similar style to be used
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: identifier)
        // Creates new annotation view if view does not exist
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            // Sets annotation
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    // defines what happens when the info button is pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let city = view.annotation as? City else {return}
        let cityName = city.title
        let cityState = (cityName?.components(separatedBy: ", "))!
        let cityLocation = Location(pCity: cityState[0], pState: cityState[1])
        let cityFact = myCityGemsModel?.getFactAboutCurrentLocation(location: cityLocation)
        let alert = UIAlertController(title: cityName, message: cityFact?.theFactDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        present(alert, animated: true)
        
        reloadTableData()
    }
    
    func sendNotification() {
        // Sends user two notification of a random fact for the nearest city
        //One occurs 10 seconds after you open the app
        //The other occurs at 9 AM
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        
        //creates the content of the notification we are going to send (title and description)
        let content = UNMutableNotificationContent()
        let closestLocation = getClosestLocation()
        var fact = myCityGemsModel?.getFactAboutCurrentLocation(location: closestLocation)
        let factCity = fact?.theLocation.theCity
        let factState = fact?.theLocation.theState
        content.title = factCity! + ", " + factState!
        content.body = fact!.theFactDescription
        
        
        
        //creates the date components for the notification at 9 AM
        var dateComponentsDaily = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        
        //sets the notification to go off at 9 AM
        dateComponentsDaily.hour = 9
        dateComponentsDaily.minute = 0
        dateComponentsDaily.second = 0
        
        
        //creates the trigger for the daily notification
        let triggerDaily = UNCalendarNotificationTrigger(dateMatching: dateComponentsDaily, repeats: true)
        
        //creates a unique identifier for the daily notification
        let uuidDaily = UUID().uuidString
        
        
        //creates the request to push the notification
        let requestDaily = UNNotificationRequest(identifier: uuidDaily, content: content, trigger: triggerDaily)
        
        notificationCenter.add(requestDaily) { (error) in
            print(error)
        }
        
        //creates a new fact for the next notification
        fact = myCityGemsModel?.getFactAboutCurrentLocation(location: closestLocation)
        content.body = fact!.theFactDescription
        
        //creates a 10 second time interval
        let date = Date().addingTimeInterval(10)
        
        //ensures that notification will be sent out 10 seconds from the current date
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        //creates the condition that allows a notification to be sent out at 10 seconds after the request is made
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //makes the unique identifier for the notification 10 seconds after the app is opened
        //notifications only work when you have exited the app
        let uuidTen = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidTen, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print(error)
        }
        
        reloadTableData()
        
    }
    func getClosestLocation() -> Location {
        let locationCoordinates = myCityGemsModel?.locationCoordinates
        var minLocation = Location(pCity: "San Diego", pState: "California")
        var minCoordinate: CLLocation = locationCoordinates![minLocation]!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            if let currentLoc = locationManager.location {
                for (key, value) in locationCoordinates! {
                    if (value.distance(from: currentLoc) < currentLoc.distance(from: minCoordinate)) {
                        minCoordinate = value
                        minLocation = key
                    }
                }
            }
            
        }
        return minLocation
    }
    /*
     reloads the table's data
     */
    func reloadTableData() -> Void {
        if let lContainerSplitViewController = self.tabBarController {
            if let lSiblingViewControllers = lContainerSplitViewController.viewControllers{
                if let lTableViewController = lSiblingViewControllers[2] as? UITableViewController {
                    if let lTableView = lTableViewController.view as? UITableView {
                        lTableView.reloadData()
                    }
                }
            }
            
        }
    }
}

