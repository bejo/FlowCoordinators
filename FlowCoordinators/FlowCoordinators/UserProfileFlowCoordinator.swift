//
//  UserProfileFlowCoordinator.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

final class UserProfileFlowCoordinator {
    private let parentViewController: UIViewController
    private let createUserProfile: ()->UserProfileSceneType

    private weak var jobDetailsViewController: UIViewController?
    private weak var jobRemovalViewController: UIViewController?

    init(parentViewController: UIViewController,
         userProfileConstructor: ()->UserProfileSceneType) {
        self.parentViewController = parentViewController
        self.createUserProfile = userProfileConstructor
    }

    func start() {
        let userProfileScene = createUserProfile()
        parentViewController.presentViewController(userProfileScene.viewController,
                                                   animated: true,
                                                   completion: nil)
    }
}
