//
//  MainFactory.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 19/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

final class MainFactory {
    //MARK: Private
    private lazy var jobsRepository: JobsRepository = { return JobsRepository() }()

    private lazy var userRepository: UserRepository = { return UserRepository() }()
}

extension MainFactory: JobDetailsSceneFactoryType {
    func createJobDetailsScene(router router: JobDetailsRouterable, jobID: Int) -> UIViewController {
        return JobDetailsViewController.createJobDetailsSceneWithRouter(router,
                                                                        jobsRepository: jobsRepository,
                                                                        jobID: jobID)
    }
}

extension MainFactory: JobRemovalSceneFactoryType {
    func createJobRemovalScene(eventHandler handler: JobRemovalViewDelegate) -> UIViewController {
        return JobRemovalViewController.createJobRemovalSceneWithEventHandler(handler)
    }
}

extension MainFactory: UserProfileFlowFactoryType {
    func createUserProfileFlow(parentViewController pvc: UIViewController) -> UserProfileFlowCoordinator {
        return UserProfileFlowCoordinator(parentViewController: pvc,
                                          userProfileSceneFactory: self)
    }
}

extension MainFactory: UserProfileSceneFactoryType {
    func createUserProfileScene() -> UserProfileSceneType {
        return UserProfileViewController.createUserProfileSceneWithUserRepo(userRepository)
    }
}
