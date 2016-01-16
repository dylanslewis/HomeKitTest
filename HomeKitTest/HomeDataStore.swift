//
//  HomeDataStore.swift
//  HomeKitTest
//
//  Created by Dylan Lewis on 16/01/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation
import HomeKit

class HomeDataStore: NSObject, HMHomeManagerDelegate, HMAccessoryBrowserDelegate {
    
    var homeManager: HMHomeManager!
    var accessoryBrowser: HMAccessoryBrowser!
    
    func setupHomeKit() {
        self.homeManager = HMHomeManager()
        self.homeManager.delegate = self
        
        self.removeAllHomes()
        self.createHomeWithName("New Home")
    }
    
    // MARK: Creators
    func createHomeWithName(name: String) {
        self.homeManager.addHomeWithName(name) { (home, error) -> Void in
            if error == nil {
                print("New Home: \(home)")
                //                self.createRoomWithName("New Room1")
                //                self.createRoomWithName("New Room2")
                //                self.createZoneWithName("New Zone")
                //
                //                self.findNewAccessories()
                
                self.getAllLightsForHome(home!)
            } else {
                print("Error \(error)")
            }
        }
    }
    
    func createRoomWithName(name: String) {
        let home = self.homeManager.primaryHome
        
        home?.addRoomWithName(name, completionHandler: { (room, error) -> Void in
            if error == nil {
                print("New Room: \(room)")
            } else {
                print("Error \(error)")
            }
        })
    }
    
    func createZoneWithName(name: String) {
        let home = self.homeManager.primaryHome
        
        home?.addZoneWithName(name, completionHandler: { (zone, error) -> Void in
            if error == nil {
                print("New Zome: \(zone)")
            } else {
                print("Error \(error)")
            }
        })
    }
    
    // MARK: Removers
    func removeHome(home: HMHome) {
        self.homeManager.removeHome(home) { (error) -> Void in
            if error == nil {
                print("Sucessfully Removed Home \(home)")
            } else {
                print("Error \(error)")
            }
        }
        
    }
    
    func removeAllHomes() {
        let homes = self.homeManager.homes
        for home in homes {
            self.removeHome(home)
        }
    }
    
    // MARK: Getters
    func getHomes() {
        let primaryHome: HMHome? = self.homeManager.primaryHome
        print("Primary Home: \(primaryHome)")
        
        for otherHome: HMHome in self.homeManager.homes {
            print("Another Home: \(otherHome)")
        }
        
        self.getRoomsForHome(primaryHome!)
        self.getAccessoriesForHome(primaryHome!)
    }
    
    func getRoomsForHome(home: HMHome) {
        for room in home.rooms {
            print("Room: \(room)")
            self.getAccessoriesForRoom(room)
        }
    }
    
    func getAccessoriesForRoom(room: HMRoom) {
        for accessory in room.accessories {
            print("Accessory: \(accessory)")
        }
    }
    
    func getAccessoriesForHome(home: HMHome) -> [HMAccessory] {
        for accessory in home.accessories {
            print("Accessory: \(accessory)")
        }
        
        return home.accessories
    }
    
    func getAllLightsForHome(home: HMHome) {
        let lights = home.servicesWithTypes([HMServiceTypeLightbulb])
        print(lights)
    }
    
    // MARK: Adders
    func addAccessory(accessory: HMAccessory, toHome home: HMHome) {
        home.addAccessory(accessory) { (error) -> Void in
            if error == nil {
                print("Added accessory \(accessory) to home \(home)")
            } else {
                print("Error \(error)")
            }
        }
    }
    
    func addAccessory(accessory: HMAccessory, toRoom room: HMRoom, inHome home: HMHome) {
        home.assignAccessory(accessory, toRoom: room) { (error) -> Void in
            if error == nil {
                print("Added accessory \(accessory) to room \(room)")
            } else {
                print("Error \(error)")
            }
        }
    }
    
    // MARK: Updaters
    func updateName(name: String, forAccessory accessory: HMAccessory) {
        accessory.updateName(name) { (error) -> Void in
            if error == nil {
                print("Updated accessory \(accessory)")
            } else {
                print("Error \(error)")
            }
        }
    }
    
    // MARK: Finders
    func findNewAccessories() {
        self.accessoryBrowser = HMAccessoryBrowser()
        self.accessoryBrowser.delegate = self
        
        self.accessoryBrowser.startSearchingForNewAccessories()
    }
    
    
    // MARK: Triggers
    func createNewTrigger() {
        //        let trigger = HMTimerTrigger(name: <#T##String#>, fireDate: <#T##NSDate#>, timeZone: <#T##NSTimeZone?#>, recurrence: <#T##NSDateComponents?#>, recurrenceCalendar: <#T##NSCalendar?#>)
        //        var trigger = HMEventTrigger(name: <#T##String#>, events: <#T##[HMEvent]#>, predicate: <#T##NSPredicate?#>)
        
        let event = HMEvent()
        event.
    }
    
    // MARK: HMAccessoryBrowserDelegate
    func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        print("Found accessory: \(accessory)")
        self.addAccessory(accessory, toHome: self.homeManager.primaryHome!)
    }
    
    func accessoryBrowser(browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        print("Removed accessory: \(accessory)")
    }
}