//
//  UserProfileFlowCoordinator.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol UserProfileSceneFactoryType {
    func createUserProfileScene()->UserProfileSceneType
}

protocol UserProfileFlowCoordinatorType {
    func start()
}

final class UserProfileFlowCoordinator: UserProfileFlowCoordinatorType {
    private let parentViewController: UIViewController
    private let userProfileSceneFactory: UserProfileSceneFactoryType

    private weak var jobDetailsViewController: UIViewController?
    private weak var jobRemovalViewController: UIViewController?

    init(parentViewController: UIViewController,
         userProfileSceneFactory: UserProfileSceneFactoryType) {
        self.parentViewController = parentViewController
        self.userProfileSceneFactory = userProfileSceneFactory
    }

    func start() {
        let userProfileScene = userProfileSceneFactory.createUserProfileScene()
        parentViewController.presentViewController(userProfileScene.viewController,
                                                   animated: true,
                                                   completion: nil)
    }
}
