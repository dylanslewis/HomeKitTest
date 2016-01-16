//
//  ViewController.swift
//  HomeKitTest
//
//  Created by Dylan Lewis on 06/01/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import UIKit
import HomeKit

class ViewController: UIViewController {
    var homeDatastore = HomeDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeDatastore.setupHomeKit()
    }
}