//
//  RootFlowCoordinator.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

/**
 Flow coordinators are responsible for routing/navigating between view controllers.

 The root coordinator is initialized with a UIWindow, child coordinators should be
 initialized only with a parent view controller.
 */
final class RootFlowCoordinator {
    private let window: UIWindow
    private let createJobDetails: (JobDetailsRouterable, Int) -> UIViewController
    private let createJobRemoval: JobRemovalSceneConstructor
    private let createUserProfileFlow: (UIViewController)->UserProfileFlowCoordinator

    private var childFlowCoordinators: [AnyObject]?
    private weak var jobDetailsViewController: UIViewController?
    private weak var jobRemovalViewController: UIViewController?

    init(window: UIWindow,
         jobDetailsConstructor: (JobDetailsRouterable, Int) -> UIViewController,
         jobRemovalConstructor: JobRemovalSceneConstructor,
         userProfileFlowConstructor: (UIViewController)->UserProfileFlowCoordinator) {
        self.window = window
        self.createJobDetails = jobDetailsConstructor
        self.createJobRemoval = jobRemovalConstructor
        self.createUserProfileFlow = userProfileFlowConstructor
    }

    func start() {
        let jobDetailsVC = createJobDetails(self, 123)
        jobDetailsViewController = jobDetailsVC

        window.rootViewController = jobDetailsVC
        window.makeKeyAndVisible()
    }

    func showUserProfile() {
        let userProfileFC = createUserProfileFlow(window.rootViewController!)
        userProfileFC.start()
    }
}

extension RootFlowCoordinator: JobDetailsRouterable {
    func showJobRemovalScreen(jobID: Int) {
        let jobRemovalVC = createJobRemoval(self)
        jobRemovalViewController = jobRemovalVC

        jobDetailsViewController?.presentViewController(jobRemovalVC, animated: true, completion: nil)
    }
}

extension RootFlowCoordinator: JobRemovalViewDelegate {
    func dismissButtonTapped() {
        jobRemovalViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
