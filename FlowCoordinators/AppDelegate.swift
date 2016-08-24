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
    let mainFactory = MainFactory()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window = window
        rootFC = RootFlowCoordinator(window: window,
                                     jobDetailsSceneFactory: mainFactory,
                                     jobRemovalSceneFactory: mainFactory,
                                     userProfileFlowFactory: mainFactory)
        rootFC?.start()
        return true
    }
}
