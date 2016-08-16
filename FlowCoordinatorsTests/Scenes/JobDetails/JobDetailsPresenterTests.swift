//
//  JobDetailsPresenterTests.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 16/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import XCTest
@testable import FlowCoordinators

class JobDetailsPresenterTests: XCTestCase {
    private var sut: JobDetailsPresenter!
    private var routerSpy: JobDetailsRouterableSpy!
    private var interactorSpy: JobDetailsInteractorSpy!
    private var viewSpy: JobDetailsViewInterfaceSpy!
    
    override func setUp() {
        super.setUp()
        routerSpy = JobDetailsRouterableSpy()
        interactorSpy = JobDetailsInteractorSpy()
        viewSpy = JobDetailsViewInterfaceSpy()
        sut = JobDetailsPresenter(router: routerSpy,
                                  interactor: interactorSpy,
                                  view: viewSpy)
    }

    func testViewDidLoad() {
        sut.viewDidLoad()

        XCTAssertEqual(viewSpy.interceptedTitle, "Test Job", "Intercepted title should be equal to the mocked one.")
        XCTAssertEqual(viewSpy.interceptedSkills, "skill#1, skill#2", "Intercepted skills should be equal to the mocked one.")
        XCTAssertEqual(viewSpy.interceptedDate, "Aug 16, 2016", "Intercepted date should be equal to the mocked one.")
    }

    func testRefresh() {
        sut.refreshButtonTapped()

        XCTAssertTrue(interactorSpy.didInvokeRefreshJob, "Presenter should ask interactor to refresh a job.")
    }

    func testRouter() {
        sut.removeButtonTapped()

        XCTAssertEqual(routerSpy.interceptedJobID, 1, "Presenter should ask router to show JobRemoval scene with for the mocked Job ID.")
    }
}

private final class JobDetailsRouterableSpy: JobDetailsRouterable {
    var interceptedJobID: Int? = nil
    private func showJobRemovalScreen(jobID: Int) {
        interceptedJobID = jobID
    }
}

private final class JobDetailsInteractorSpy: JobDetailsInteractable {
    var didInvokeJob = false
    var job: Job {
        get {
            didInvokeJob = true
            return Job(id: 1,
                       createdAt: NSDate.init(timeIntervalSince1970: 1471351754),
                       title: "Test Job",
                       skills: ["skill#1", "skill#2"])
        }
    }

    var didInvokeRefreshJob = false
    func refreshJob() {
        didInvokeRefreshJob = true
    }
}

private final class JobDetailsViewInterfaceSpy: JobDetailsViewInterface {
    var interceptedTitle: String? = nil
    private func displayTilte(title: String) {
        interceptedTitle = title
    }

    var interceptedSkills: String? = nil
    private func displaySkills(skills: String) {
        interceptedSkills = skills
    }

    var interceptedDate: String? = nil
    private func displayCreationDate(date: String) {
        interceptedDate = date
    }
}
