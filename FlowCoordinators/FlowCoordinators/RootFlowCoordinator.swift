//
//  RootFlowCoordinator.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol UserProfileFlowFactoryType {
    func createUserProfileFlow(parentViewController _: UIViewController) -> UserProfileFlowCoordinator
}

protocol JobDetailsSceneFactoryType {
    func createJobDetailsScene(router _: JobDetailsRouterable,
                               jobID: Int) -> UIViewController
}

protocol JobRemovalSceneFactoryType {
    func createJobRemovalScene(eventHandler _: JobRemovalViewDelegate) -> UIViewController
}

/**
 Flow coordinators are responsible for routing/navigating between view controllers.

 The root coordinator is initialized with a UIWindow, child coordinators should be
 initialized only with a parent view controller.
 */
final class RootFlowCoordinator {
    private let window: UIWindow
    private let jobDetailsSceneFactory: JobDetailsSceneFactoryType
    private let jobRemovalSceneFactory: JobRemovalSceneFactoryType
    private let userProfileFlowFactory: UserProfileFlowFactoryType

    private var childFlowCoordinators: [AnyObject]?
    private weak var jobDetailsViewController: UIViewController?
    private weak var jobRemovalViewController: UIViewController?

    init(window: UIWindow,
         jobDetailsSceneFactory: JobDetailsSceneFactoryType,
         jobRemovalSceneFactory: JobRemovalSceneFactoryType,
         userProfileFlowFactory: UserProfileFlowFactoryType) {
        self.window = window
        self.jobDetailsSceneFactory = jobDetailsSceneFactory
        self.jobRemovalSceneFactory = jobRemovalSceneFactory
        self.userProfileFlowFactory = userProfileFlowFactory
    }

    func start() {
        let jobDetailsVC = jobDetailsSceneFactory.createJobDetailsScene(router: self,
                                                                        jobID: 123)
        jobDetailsViewController = jobDetailsVC

        window.rootViewController = jobDetailsVC
        window.makeKeyAndVisible()
    }

    func showUserProfile() {
        let userProfileFC = userProfileFlowFactory.createUserProfileFlow(parentViewController: window.rootViewController!)
        userProfileFC.start()
    }
}

extension RootFlowCoordinator: JobDetailsRouterable {
    func showJobRemovalScreen(jobID: Int) {
        let jobRemovalVC = jobRemovalSceneFactory.createJobRemovalScene(eventHandler: self)
        jobRemovalViewController = jobRemovalVC

        jobDetailsViewController?.presentViewController(jobRemovalVC, animated: true, completion: nil)
    }
}

extension RootFlowCoordinator: JobRemovalViewDelegate {
    func dismissButtonTapped() {
        jobRemovalViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
