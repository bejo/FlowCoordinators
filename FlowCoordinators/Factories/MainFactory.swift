//
//  MainFactory.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 19/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

final class MainFactory {
    func jobDetailsConstructor(router: JobDetailsRouterable,
                               jobID: Int) -> UIViewController {
        return JobDetailsViewController.createJobDetailsSceneWithRouter(router,
                                                                        jobsRepository: jobsRepository,
                                                                        jobID: jobID)
    }

    func userProfileFlowCoordinatorConstructor(parentViewController: UIViewController) -> UserProfileFlowCoordinator {
        return UserProfileFlowCoordinator(parentViewController: parentViewController,
                                          userProfileConstructor: userProfileSceneConstructor )
    }

    //MARK: Private
    private lazy var jobsRepository: JobsRepository = { return JobsRepository() }()

    private lazy var userRepository: UserRepository = { return UserRepository() }()

    private func userProfileSceneConstructor() -> UserProfileSceneType {
        return UserProfileViewController.createUserProfileSceneWithUserRepo(userRepository)
    }
}
