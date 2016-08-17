//
//  JobDetailsViewModelTests.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import XCTest
@testable import FlowCoordinators

class JobDetailsViewModelTests: XCTestCase {
    private var jobsRepoSpy: JobsRepositorySpy!
    private var sut: JobDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        jobsRepoSpy = JobsRepositorySpy()
        sut = JobDetailsViewModel(jobsRepository: jobsRepoSpy, jobID: 123)
    }

    func testTitleDisplay() {
        XCTAssertEqual(sut.title, "Test job", "Intercepted title should be equal to the mocked one.")
    }

    func testCreationDateDisplay() {
        XCTAssertEqual(sut.creationDate, "Aug 16, 2016", "Intercepted date should be equal to the mocked one.")
    }

    func testSkillsDisplay() {
        XCTAssertEqual(sut.skillsList, "skill#1, skill#2", "Intercepted skills should be equal to the mocked one.")
    }
    
    func testJobRefresh() {
        sut.refreshJob()

        XCTAssertTrue(jobsRepoSpy.didInvokeRefreshJob, "View model should ask repository to refresh a job.")
    }

    func testDelegateCallback() {
        let delegateSpy = JobDetailsViewModelDelegateSpy()
        sut.delegate = delegateSpy
        sut.refreshJob()

        XCTAssertTrue(delegateSpy.didInvokeJobDidChange, "View model should call delegate after a job refresh is refreshed.")
    }
}

private final class JobsRepositorySpy: JobsRepositoryType {
    var interceptedJobID: Int? = nil
    private func jobWithID(jobID: Int) -> Job {
        interceptedJobID = jobID
        return Job(id: jobID,
                   createdAt: NSDate.init(timeIntervalSince1970: 1471351754),
                   title: "Test job",
                   skills: ["skill#1", "skill#2"])

    }

    var didInvokeRefreshJob = false
    func refreshJob(job: Job) -> Job {
        didInvokeRefreshJob = true
        return job
    }
}

private final class JobDetailsViewModelDelegateSpy: JobDetailsViewModelDelegate {
    var didInvokeJobDidChange = false
    private func jobDidChange() {
        didInvokeJobDidChange = true
    }
}
