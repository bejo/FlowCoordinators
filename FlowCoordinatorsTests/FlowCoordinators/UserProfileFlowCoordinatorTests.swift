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
    private var parentViewController: ViewControllerSpy!
    private var constructorSpy: UserProfileConstructorSpy!
    private var sut: UserProfileFlowCoordinator!

    override func setUp() {
        super.setUp()
        parentViewController = ViewControllerSpy()
        constructorSpy = UserProfileConstructorSpy()
        sut = UserProfileFlowCoordinator(parentViewController: parentViewController,
                                         userProfileConstructor: constructorSpy.constructor)
    }

    func testStart() {
        sut.start()

        let presentedVC = parentViewController.interceptedViewControllerToPresent
        let userProfileVC = constructorSpy.scene.viewController
        XCTAssertEqual(presentedVC, userProfileVC, "The coordinator should present the user profile VC.")
    }
}

final class UserProfileConstructorSpy {
    let scene = UserProfileSceneSpy()
    func constructor() -> UserProfileSceneType {
        return self.scene
    }
}

final class UserProfileSceneSpy: UserProfileSceneType {
    let viewController = UIViewController()
}

final class ViewControllerSpy: UIViewController {
    var interceptedViewControllerToPresent: UIViewController? = nil
    override func presentViewController(viewControllerToPresent: UIViewController,
                                        animated flag: Bool,
                                                 completion: (() -> Void)?) {
        interceptedViewControllerToPresent = viewControllerToPresent
    }
}
