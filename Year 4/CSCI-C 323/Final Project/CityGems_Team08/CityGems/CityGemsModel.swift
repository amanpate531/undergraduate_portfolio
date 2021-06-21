//
//  Names: Taral Shah, Aman Patel, Vijay Tewari
//  Emails: tarshah@iu.edu, amanpate@iu.edu, vtewari@iu.edu
//  App Name: CityGems
//  Submission Date: May 4, 2021

//  CityGemsModel.swift
//  CityGems
//
//  Created by Vijay  Tewari on 4/19/21.
//

import Foundation
import CoreData
import MapKit
import CoreLocation

class CityGemsModel  {
    
    var locationCoordinates: [Location : CLLocation] = [:]
    /*
     every fact in the program
     */
    var allFacts: [Location : Set<Fact>] = [:]
    
    /*
     all of the facts that the cannot be displayed to the
     user by a notification/map annotation
     */
    var previousFacts: [Location : Set<Fact>] = [:]
    
    /*
     all of the facts displayed in the table view
     */
    var tableFacts: [Location : Set<Fact>] = [:]
    
    /*
     the context for Core Data
     */
    let context = AppDelegate.viewContext
    
    init() {
        self.addLocations()
        //modelTests()
        loadPreviousFacts()
        loadAddedFacts()
        loadTableFacts()
        let btown = Location(pCity: "Bloomington", pState: "Indiana")
        let chicago = Location(pCity: "Chicago", pState: "Illinois")
        let sanDiego = Location(pCity: "San Diego", pState: "California")
        let btownFact1 = Fact(pFactDescription: "Indiana University is here", pLocation: btown)
        let btownFact2 = Fact(pFactDescription: "Lots of restaurants", pLocation: btown)
        let btownFact3 = Fact(pFactDescription: "Most squirrels in the world", pLocation: btown)
        let northwesternFact = Fact(pFactDescription: "Northwestern University is here", pLocation: chicago)
        let chicagoFact2 = Fact(pFactDescription: "A lot of Indiana University graduates plan to live here after graduation. For some reason, students like living in Chicago more than Bloomington.", pLocation: chicago)
        let UCSDFact = Fact(pFactDescription: "UCSD is here", pLocation: sanDiego)
        let testingFacts = [btownFact1, btownFact2, northwesternFact, UCSDFact, btownFact3, chicagoFact2]
        testingFacts.forEach { fact in
            addFact(location: fact.theLocation, fact_description: fact.theFactDescription)
        }
        
    }
    
    func addLocations() {
        locationCoordinates[Location(pCity: "Bloomington", pState: "Indiana")] = CLLocation(latitude: 39.1653, longitude: -86.5624)
        locationCoordinates[Location(pCity: "Charlottesville", pState: "Virginia")] = CLLocation(latitude: 38.0293, longitude: -78.4767)
        locationCoordinates[Location(pCity: "Chicago", pState: "Illinois")] = CLLocation(latitude: 41.8781, longitude: -87.6298)
        locationCoordinates[Location(pCity: "San Diego", pState: "California")] = CLLocation(latitude: 32.7157, longitude: -117.1611)
    }
    
    /*
     loads all of the previous facts from Core Data into self.previousFacts
     */
    func loadPreviousFacts() -> Void {
        let notificationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PreviousNotification")
        
        do {
            let fetchedNotifications = try context.fetch(notificationFetch) as! [PreviousNotification]
            fetchedNotifications.forEach { prev in
                addPreviousNotificationToPreviousFacts(previousNotification: prev)
            }
        } catch {
            fatalError("Failed to fetch previous notifications: \(error)")
        }
    }
    
    /*
     adds the given PreviousNotification (an NSManagedObject
     fetched from Core Data) to self.previousFacts
     */
    func addPreviousNotificationToPreviousFacts(previousNotification: PreviousNotification) -> Void {
        let fact_description: String = previousNotification.value(forKey: "fact") as! String
        let city: String = previousNotification.value(forKey: "city") as! String
        let state: String = previousNotification.value(forKey: "state") as! String
        let factLocation: Location = Location(pCity: city, pState: state)
        addPreviousFact(location: factLocation, fact_description: fact_description)
    }
    
    /*
     loads all of the added facts from Core Data into self.allFacts
     */
    func loadAddedFacts() -> Void {
        let addedFactsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AddedFact")
        
        do {
            let fetchedAddedFacts = try context.fetch(addedFactsFetch) as! [AddedFact]
            fetchedAddedFacts.forEach { added in
                addAddedFactToAllFacts(addedFact: added)
            }
        } catch {
            fatalError("Failed to fetch added facts: \(error)")
        }
    }
    
    /*
     adds the given AddedFact (an NSManagedObject
     fetched from Core Data) to self.allFacts
     */
    func addAddedFactToAllFacts(addedFact: AddedFact) -> Void {
        let fact_description: String = addedFact.value(forKey: "factAdded") as! String
        let city: String = addedFact.value(forKey: "cityAdded") as! String
        let state: String = addedFact.value(forKey: "stateAdded") as! String
        let factLocation: Location = Location(pCity: city, pState: state)
        addFact(location: factLocation, fact_description: fact_description)
    }
    
    /*
     loads all of the table facts from Core Data into self.tableFacts
     */
    func loadTableFacts() -> Void {
        let tableFactsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TableFact")
        
        do {
            let fetchedTableFacts = try context.fetch(tableFactsFetch) as! [TableFact]
            fetchedTableFacts.forEach { fact in
                addTableFactToTableFacts(tableFact: fact)
            }
        } catch {
            fatalError("Failed to fetch table facts: \(error)")
        }
    }
    
    /*
     adds the given TableFact (an NSManagedObject
     fetched from Core Data) to self.tableFacts
     */
    func addTableFactToTableFacts(tableFact: TableFact) -> Void {
        let fact_description: String = tableFact.value(forKey: "factTable") as! String
        let city: String = tableFact.value(forKey: "cityTable") as! String
        let state: String = tableFact.value(forKey: "stateTable") as! String
        let factLocation: Location = Location(pCity: city, pState: state)
        addTableFact(location: factLocation, fact_description: fact_description)
    }
    
    func getTableFacts() -> [Location : Set<Fact>] {
        return self.tableFacts
    }
    
    func getPreviousFacts() -> [Location : Set<Fact>] {
        return self.previousFacts
    }
    
    func getLocations() -> Dictionary<Location, Set<Fact>>.Keys {
        return self.allFacts.keys
    }
    
    /*
     returns and stores into Core Data and self.previousFacts a Fact about the given Location that the user hasn't seen yet; if the user has seen all of them, cycles back through; if there are no facts about the given Location, returns nil
     */
    func getFactAboutCurrentLocation(location: Location) -> Fact? {
        
        //if allFacts has a key corresponding to location
        if let allFactsAtLocation: Set<Fact> = allFacts[location] {
            //if allFactsAtLocation is empty, there are no facts;
            //this shouldn't happen with our implementation because
            //we never insert an empty set into allFacts
            if (allFactsAtLocation.isEmpty) {
                return nil
            }
            
            let previousFactsAtLocation: Set<Fact> = previousFacts[location] ?? Set<Fact>()
            
            //return any Fact contained in allFactsAtLocation that isn't in previousFactsAtLocation
            for candidate in allFactsAtLocation {
                //if previousFactsAtLocation doesn't contain the candidate Fact, store the candidate Fact into Core Data and self.previousFacts and return it
                if (!previousFactsAtLocation.contains(candidate)) {
                    addAndStoreTableFact(candidate: candidate)
                    return addAndStorePreviousFact(candidate: candidate)
                }
            }
            
            //if all the Facts contained in allFactsAtLocation were also in previousFactsAtLocation, delete the previous facts about the location from both self.previousFacts and Core Data
            deletePreviousFactsFromLocation(location: location)
            
            //after deleting the previous facts about the location, we can just take the first fact from allFactsAtLocation; the first fact is guaranteed to exist because we checked earlier if allFactsAtLocation is empty
            return addAndStorePreviousFact(candidate: allFactsAtLocation.first!)
            
        }
        //if allFacts doesn't have a key corresponding to location, there are no facts
        else {
            return nil
        }
    }
    func getAnnotations() -> [MKAnnotation] {
        let locations = getLocations()
        var annotations : [City] = []
        for key in locations {
            let factCity = key.theCity
            let factState = key.theState
            let title = factCity + ", " + factState
            let coordinateL = locationCoordinates[key]
            let coordinate = (coordinateL?.coordinate)!
            let annotation = City(title: title, coordinate: coordinate, fact: "Placeholder")
            annotations.append(annotation)
        }
        return annotations
    }
    /*
     adds the given fact to self.previousFacts AND to Core Data and returns it
     */
    func addAndStorePreviousFact(candidate: Fact) -> Fact {
        candidate.storePreviousNotification()
        addPreviousFact(location: candidate.theLocation, fact_description: candidate.theFactDescription)
        return candidate
    }
    
    /*
     deletes all previous facts about the given location from self.previousFacts and from Core Data
     */
    func deletePreviousFactsFromLocation(location: Location) -> Void {
        previousFacts[location] = Set<Fact>()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PreviousNotification")
        fetchRequest.predicate = NSPredicate(format: "city == %@ AND state == %@", location.theCity, location.theState)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            fatalError("Failed to delete previous notifications: \(error)")
        }
        
        do {
            try context.save()
        } catch {
            print("context saving failed")
        }
    }
    
    /*
     adds the given fact to self.tableFacts AND to Core Data and returns it
     */
    func addAndStoreTableFact(candidate: Fact) -> Fact {
        candidate.storeTableFact()
        addTableFact(location: candidate.theLocation, fact_description: candidate.theFactDescription)
        return candidate
    }
    
    /*
     adds the given fact to self.allFacts AND to Core Data and returns it
     */
    func addAndStoreFact(location: Location, fact_description: String) -> Fact {
        let newFact: Fact = Fact(pFactDescription: fact_description, pLocation: location)
        newFact.storeAddedFact()
        addFact(location: newFact.theLocation, fact_description: newFact.theFactDescription)
        return newFact
    }
    
    /*
     adds the given fact to self.tableFacts but not to Core Data
     */
    func addTableFact(location: Location, fact_description: String) -> Void {
        let newFact: Fact = Fact(pFactDescription: fact_description, pLocation: location)
        if var oldValue : Set<Fact> = tableFacts[location] {
            oldValue.insert(newFact)
            tableFacts[location] = oldValue
        }
        else {
            tableFacts[location] = Set<Fact>([newFact])
        }
    }
    
    /*
     adds the given fact to self.allFacts but not to Core Data
     */
    func addFact(location: Location, fact_description: String) -> Void {
        let newFact: Fact = Fact(pFactDescription: fact_description, pLocation: location)
        if var oldValue : Set<Fact> = allFacts[location] {
            oldValue.insert(newFact)
            allFacts[location] = oldValue
        }
        else {
            allFacts[location] = Set<Fact>([newFact])
        }
    }
    
    /*
     adds the given fact to self.previousFacts but not to Core Data
     */
    func addPreviousFact(location: Location, fact_description: String) -> Void {
        let newFact: Fact = Fact(pFactDescription: fact_description, pLocation: location)
        if var oldValue : Set<Fact> = previousFacts[location] {
            oldValue.insert(newFact)
            previousFacts[location] = oldValue
        }
        else {
            previousFacts[location] = Set<Fact>([newFact])
        }
    }
    
    /*
     returns an array representation of the given dictionary
     */
    func dictionaryToArray(theDictionary: Dictionary<Location, Set<Fact>>) -> [(key: Location, value: [Fact])] {
        return theDictionary.map { pair in
            return (pair.key, Array(pair.value))
        }
    }
    
    /*
     Tests for the model
     */
    func modelTests() -> Void {
        print("addFact() tests")
        print("----------------------------------------")
        print()
        let btown = Location(pCity: "Bloomington", pState: "Indiana")
        let chicago = Location(pCity: "Chicago", pState: "Illinois")
        let sanDiego = Location(pCity: "San Diego", pState: "California")
        let charlottesville = Location(pCity: "Charlottesville", pState: "Virginia")
        let btownFact1 = Fact(pFactDescription: "Indiana University is here", pLocation: btown)
        let btownFact2 = Fact(pFactDescription: "Lots of restaurants", pLocation: btown)
        let btownFact3 = Fact(pFactDescription: "Most squirrels in the world", pLocation: btown)
        let northwesternFact = Fact(pFactDescription: "Northwestern University is here", pLocation: chicago)
        let UCSDFact = Fact(pFactDescription: "UCSD is here", pLocation: sanDiego)
        let testingFacts = [btownFact1, btownFact2, northwesternFact, UCSDFact, btownFact3]
        print("--------All Facts Before Adding Facts--------")
        print(allFacts)
        print("--------All Facts After Adding Facts--------")
        testingFacts.forEach { fact in
            addFact(location: fact.theLocation, fact_description: fact.theFactDescription)
        }
        print(allFacts)
        print()
        print()
        print()
        
        print("loadPreviousFacts() tests")
        print("----------------------------------------")
        print()
        print("--------Previous Facts Before Loading Previous Facts--------")
        print(previousFacts)
        print("--------Previous Facts After Loading Previous Facts--------")
        loadPreviousFacts()
        print(previousFacts)
        print()
        print()
        print()
        
        print("getFactAboutCurrentLocation() tests")
        print("----------------------------------------")
        print()
        print("--------getFactAboutCurrentLocation(location: btown)--------")
        print(getFactAboutCurrentLocation(location: btown))
        print("--------getFactAboutCurrentLocation(location: btown)--------")
        print(getFactAboutCurrentLocation(location: btown))
        print("--------getFactAboutCurrentLocation(location: btown)--------")
        print(getFactAboutCurrentLocation(location: btown))
        print("--------getFactAboutCurrentLocation(location: btown)--------")
        print(getFactAboutCurrentLocation(location: btown))
        print("--------getFactAboutCurrentLocation(location: btown)--------")
        print(getFactAboutCurrentLocation(location: btown))
        print("--------getFactAboutCurrentLocation(location: chicago)--------")
        print(getFactAboutCurrentLocation(location: chicago))
        print("--------getFactAboutCurrentLocation(location: sanDiego)--------")
        print(getFactAboutCurrentLocation(location: sanDiego))
        print("--------getFactAboutCurrentLocation(location: charlottesville)--------")
        print(getFactAboutCurrentLocation(location: charlottesville))
        print("--------Previous Facts After All Calls to getFactAboutCurrentLocation()--------")
        print(previousFacts)
        print("--------Core Data Previous Facts After All Calls to getFactAboutCurrentLocation()--------")
        previousFacts = [:]
        loadPreviousFacts()
        print(previousFacts)
        print()
        print()
        print()
        
        print("deletePreviousFactsFromLocation() tests")
        print("----------------------------------------")
        print()
        print("--------Previous Facts Before Deleting Btown--------")
        print(previousFacts)
        print("--------Core Data Previous Facts Before Deleting Btown--------")
        previousFacts = [:]
        loadPreviousFacts()
        print(previousFacts)
        print("--------Previous Facts After Deleting Btown--------")
        deletePreviousFactsFromLocation(location: btown)
        print(previousFacts)
        print("--------Core Data Previous Facts After Deleting Btown--------")
        previousFacts = [:]
        loadPreviousFacts()
        print(previousFacts)
        print()
        print()
        print()
        
        print("loadAddedFacts() tests")
        print("----------------------------------------")
        print()
        print("--------All Facts Before Loading Added Facts--------")
        print(allFacts)
        print("--------All Facts After Loading Added Facts--------")
        loadAddedFacts()
        print(allFacts)
        print()
        print()
        print()
        
        print("addAndStoreFact() tests")
        print("----------------------------------------")
        print()
        print("--------addAndStoreFact(location: btown, fact_description: This is btown!)--------")
        print(addAndStoreFact(location: btown, fact_description: "This is btown!"))
        print("--------addAndStoreFact(location: btown, fact_description: This is btown again!)--------")
        print(addAndStoreFact(location: btown, fact_description: "This is btown again!"))
        print("--------addAndStoreFact(location: charlottesville, fact_description: This is charlottesville!)--------")
        print(addAndStoreFact(location: charlottesville, fact_description: "This is charlottesville!"))
        print("--------All Facts After All Calls to addAndStoreFact()--------")
        print(allFacts)
        print("--------Core Data All Facts After All Calls to addAndStoreFact()--------")
        allFacts = [:]
        loadAddedFacts()
        print(allFacts)
        print()
        print()
        print()
    }
    
}

class Fact: CustomStringConvertible, Hashable {
    
    /*
     return whether the given two facts are equal
     */
    static func == (lhs: Fact, rhs: Fact) -> Bool {
        return lhs.theFactDescription == rhs.theFactDescription &&
            lhs.theLocation == rhs.theLocation
    }
    
    /*
     hash function to conform to Hashable protocol
     */
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.theFactDescription)
        hasher.combine(self.theLocation)
    }
    
    /*
     the context for Core Data
     */
    let context = AppDelegate.viewContext
    
    var theFactDescription: String
    var theLocation: Location
    
    public var description: String {
        return "\nFact: \(theFactDescription)\nCity: \(theLocation.theCity)\nState: \(theLocation.theState)\n"
    }
    
    init(pFactDescription: String, pLocation: Location) {
        self.theFactDescription = pFactDescription
        self.theLocation = pLocation
    }
    
    /*
     stores the Fact into Core Data's PreviousNotification entity
     */
    func storePreviousNotification() -> Void {
        let myFact1: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "PreviousNotification", into: context)
        myFact1.setValue(theFactDescription, forKey: "fact")
        myFact1.setValue(theLocation.theCity, forKey: "city")
        myFact1.setValue(theLocation.theState, forKey: "state")
        
        do {
            try context.save()
        } catch {
            print("context saving failed")
        }
    }
    
    /*
     stores the Fact into Core Data's AddedFact entity
     */
    func storeAddedFact() -> Void {
        let myFact1: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "AddedFact", into: context)
        myFact1.setValue(theFactDescription, forKey: "factAdded")
        myFact1.setValue(theLocation.theCity, forKey: "cityAdded")
        myFact1.setValue(theLocation.theState, forKey: "stateAdded")
        
        do {
            try context.save()
        } catch {
            print("context saving failed")
        }
    }
    
    /*
     stores the Fact into Core Data's AddedFact entity
     */
    func storeTableFact() -> Void {
        let myFact1: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "TableFact", into: context)
        myFact1.setValue(theFactDescription, forKey: "factTable")
        myFact1.setValue(theLocation.theCity, forKey: "cityTable")
        myFact1.setValue(theLocation.theState, forKey: "stateTable")
        
        do {
            try context.save()
        } catch {
            print("context saving failed")
        }
    }
}

class Location: CustomStringConvertible, Hashable {
    
    /*
     return whether the given two locations are equal
     */
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.theCity == rhs.theCity &&
            lhs.theState == rhs.theState
    }
    
    /*
     hash function to conform to Hashable protocol
     */
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.theCity)
        hasher.combine(self.theState)
    }
    
    var theCity: String
    var theState: String
    
    public var description: String {
        return "\n\nCity: \(self.theCity)\nState: \(self.theState)\n"
    }
    
    init(pCity: String, pState: String) {
        self.theCity = pCity;
        self.theState = pState;
    }
}

class City: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var fact: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, fact: String) {
        self.title = title
        self.coordinate = coordinate
        self.fact = fact
    }
}
