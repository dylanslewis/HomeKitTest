//
//  HomeKitDatabaseObserver.swift
//  HomeKitTest
//
//  Created by Dylan Lewis on 16/01/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation
import HomeKit

class HomeKitDatabaseObserver: NSObject, HMHomeManagerDelegate, HMHomeDelegate, HMAccessoryDelegate {
    var homeManager: HMHomeManager!
    var home: HMHome!
    
    var homeDatastore = HomeDataStore()

    var currentAccessory: HMAccessory!
    
    func setup() {
        self.setupHomeManager()
        self.setupHome()
        
        self.homeDatastore.getAccessoriesForHome(self.home)
    }
    
    func setupHomeManager() {
        self.homeManager = HMHomeManager()
        self.homeManager.delegate = self
    }
    
    func setupHome() {
        self.home = self.homeManager.primaryHome
        self.home.delegate = self
    }
    
    func setupAccessory(accessory: HMAccessory) {
        let accessories = self.homeDatastore.getAccessoriesForHome(self.home)
        
        self.currentAccessory = accessories.first
        self.currentAccessory.delegate = self
    }
    
    func completionHandler() {
        // Check that update was successful before updating the views.
    }
    
    func delegateHandler() {
        // Update the views.
    }
    
    func handleDatabaseChange() {
        // This should be called by both the completionHandler and the associated delegate method.
        // Reload the data and update any associated views.
        // If the Home layout changes significantly, reload all the information about the Home.
    }

    // MARK: HMHomeManagerDelegate
    
    // These methods are related to updates to entire homes.
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        // Send update all homes notification.
    }
    
    func homeManagerDidUpdatePrimaryHome(manager: HMHomeManager) {
        // Send update primary home notification.
    }
    
    // MARK: HMHomeDelegate
    
    // These updates are related to updates within a home.
    func home(home: HMHome, didAddAccessory accessory: HMAccessory) {
        
    }
    
    func home(home: HMHome, didRemoveAccessory accessory: HMAccessory) {
        
    }
    
    // MARK: HMAccessoryDelegate
    func accessoryDidUpdateReachability(accessory: HMAccessory) {
        if accessory.reachable == true {
            // Can communicate with the accessory
        } else {
            // The accessory is out of range, turned off, etc.
            // Inform users about how live Apple TV is.
        }
    }
    
}