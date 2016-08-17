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
    private let createJobDetails: JobDetailsSceneConstructor
    private let createJobRemoval: JobRemovalSceneConstructor
    private let jobsRepository: JobsRepository // here the coordinator acts also as a dependency container

    private weak var jobDetailsViewController: UIViewController?
    private weak var jobRemovalViewController: UIViewController?

    init(window: UIWindow,
         jobDetailsConstructor: JobDetailsSceneConstructor,
         jobRemovalConstructor: JobRemovalSceneConstructor,
         jobsRepository: JobsRepository) {
        self.window = window
        self.createJobDetails = jobDetailsConstructor
        self.createJobRemoval = jobRemovalConstructor
        self.jobsRepository = jobsRepository
    }

    func start() {
        let jobDetailsVC = createJobDetails(self, jobsRepository, 123)
        jobDetailsViewController = jobDetailsVC

        window.rootViewController = jobDetailsVC
        window.makeKeyAndVisible()
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
