//
//  AppDelegate.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootFC: RootFlowCoordinator? // The root coordinator lifetime should be equal to application's lifetime. Therefore it's strongly retained by AppDelegate.

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window = window
        rootFC = RootFlowCoordinator.init(window: window,
                                          jobDetailsConstructor: JobDetailsViewController.createJobDetailsSceneWithRouter,
                                          jobRemovalConstructor: JobRemovalViewController.createJobRemovalSceneWithEventHandler,
                                          jobsRepository: JobsRepository())
        rootFC?.start()
        return true
    }
}
