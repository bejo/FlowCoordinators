//
//  UserProfileFlowCoordinatorTests.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 18/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import XCTest
@testable import FlowCoordinators

class UserProfileFlowCoordinatorTests: XCTestCase {
    private var parentViewControllerSpy: ViewControllerSpy!
    private var sceneFactorySpy: UserProfileSceneFactorySpy!
    private var sut: UserProfileFlowCoordinator!

    override func setUp() {
        super.setUp()
        parentViewControllerSpy = ViewControllerSpy()
        sceneFactorySpy = UserProfileSceneFactorySpy()
        sut = UserProfileFlowCoordinator(parentViewController: parentViewControllerSpy,
                                         userProfileSceneFactory: sceneFactorySpy)
    }

    func testStart() {
        sut.start()

        let presentedVC = parentViewControllerSpy.interceptedViewControllerToPresent
        let userProfileVC = sceneFactorySpy.returnedScene.viewController
        XCTAssertEqual(presentedVC, userProfileVC, "The coordinator should present the user profile VC.")
    }
}

final class UserProfileSceneFactorySpy: UserProfileSceneFactoryType {
    let returnedScene = UserProfileSceneSpy()
    func createUserProfileScene() -> UserProfileSceneType {
        return returnedScene
    }
}

final class UserProfileSceneSpy: UserProfileSceneType {
    let viewController = UIViewController()
}
