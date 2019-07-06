//
//  AppDelegate.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

@UIApplicationMain

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var coreDataManager: CoreDataManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initialSetUp()
        return true
    }
    private func initialSetUp() {
        coreDataManager = CoreDataManager(CoreDataConstants.SimpleQuiz)
        
        if let rootController = self.window?.rootViewController as? UINavigationController,
            let homeController = rootController.viewControllers[0] as? HomeViewController
            {
            homeController.coreDataManager = coreDataManager
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        
        coreDataManager?.saveChanges(nil)
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        coreDataManager?.saveChanges(nil)
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
