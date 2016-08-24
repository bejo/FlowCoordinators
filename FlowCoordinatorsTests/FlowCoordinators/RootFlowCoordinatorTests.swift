//
//  RootFlowCoordinatorTests.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 24/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import XCTest
@testable import FlowCoordinators

class RootFlowCoordinatorTests: XCTestCase {
    private var windowSpy: WindowSpy!
    private var jobDetailsFactorySpy: JobDetailsFactorySpy!
    private var jobRemovalFactorySpy: JobRemovalFactorySpy!
    private var userProfileFlowFactorySpy: UserProfileFlowFactorySpy!
    private var sut: RootFlowCoordinator!

    override func setUp() {
        super.setUp()
        windowSpy = WindowSpy()
        jobDetailsFactorySpy = JobDetailsFactorySpy()
        jobRemovalFactorySpy = JobRemovalFactorySpy()
        userProfileFlowFactorySpy = UserProfileFlowFactorySpy()
        sut = RootFlowCoordinator(window: windowSpy,
                                  jobDetailsSceneFactory: jobDetailsFactorySpy,
                                  jobRemovalSceneFactory: jobRemovalFactorySpy,
                                  userProfileFlowFactory: userProfileFlowFactorySpy)
    }

    func testStart() {
        sut.start()

        let presentedVC = windowSpy.interceptedRootViewController
        let jobDetailsVC = jobDetailsFactorySpy.returnedScene
        XCTAssertEqual(presentedVC, jobDetailsVC, "The coordinator should present a Job Details VC.")
    }

    func testShowUserProfile() {
        sut.start()
        sut.showUserProfile()

        XCTAssertTrue(userProfileFlowFactorySpy.returnedFlow.didInvokeStart, "The coordinator should invoke start() on a User Profile Flow Coordinator.")
    }

    func testShowJobRemovalScreen() {
        sut.start()
        sut.showJobRemovalScreen(123)

        let presentedVC = jobDetailsFactorySpy.returnedScene.interceptedViewControllerToPresent
        let jobRemovalVC = jobRemovalFactorySpy.returnedScene
        XCTAssertEqual(presentedVC, jobRemovalVC, "The coordinator should present a Job Removal VC over a Job Details VC.")
    }
}

private final class JobDetailsFactorySpy: JobDetailsSceneFactoryType {
    var returnedScene = ViewControllerSpy()
    private func createJobDetailsScene(router _: JobDetailsRouterable, jobID: Int) -> UIViewController {
        return returnedScene
    }
}

private final class JobRemovalFactorySpy: JobRemovalSceneFactoryType {
    var returnedScene = ViewControllerSpy()
    private func createJobRemovalScene(eventHandler _: JobRemovalViewDelegate) -> UIViewController {
        return returnedScene
    }
}

private final class UserProfileFlowFactorySpy: UserProfileFlowFactoryType {
    var returnedFlow = UserProfileFlowCoordinatorSpy()
    private func createUserProfileFlow(parentViewController pvc: UIViewController) -> UserProfileFlowCoordinatorType {
        return returnedFlow
    }
}

private final class UserProfileFlowCoordinatorSpy: UserProfileFlowCoordinatorType {
    var didInvokeStart = false
    private func start() {
        didInvokeStart = true
    }
}

private final class WindowSpy: UIWindow {
    var interceptedRootViewController: UIViewController? = nil
    private override var rootViewController: UIViewController? {
        didSet {
            interceptedRootViewController = rootViewController
        }
    }
}
