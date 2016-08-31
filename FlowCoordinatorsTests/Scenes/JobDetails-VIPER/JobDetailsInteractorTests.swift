//
//  JobDetailsInteractor.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 16/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import XCTest
@testable import FlowCoordinators

class JobDetailsInteractorTests: XCTestCase {
    private var sut: JobDetailsInteractor!
    private var jobsRepoSpy: JobsRepositorySpy!
    private var delegateSpy: JobDetailsInteractableDelegateSpy!

    override func setUp() {
        super.setUp()
        jobsRepoSpy = JobsRepositorySpy()
        delegateSpy = JobDetailsInteractableDelegateSpy()
        sut = JobDetailsInteractor(jobsRepository: jobsRepoSpy, jobID: 123)
        sut.delegate = delegateSpy
    }

    func testInitialJob() {
        let job = sut.job

        XCTAssertEqual(job.id, 123, "Job ID should be equal to the mocked value.")
        XCTAssertEqual(jobsRepoSpy.interceptedJobID, 123, "Interactor should intercept a correct ID of the mocked job.")
    }
    
    func testJobRefresh() {
        sut.refreshJob()

        XCTAssertTrue(jobsRepoSpy.didInvokeRefreshJob, "Interactor should ask repo to refresh a job.")
        XCTAssertTrue(delegateSpy.didInvokeJobDidChange, "Interactor should tell delegate that a job changed.")
    }
}

private final class JobsRepositorySpy: JobsRepositoryType {
    var interceptedJobID: Int? = nil
    private func jobWithID(jobID: Int) -> Job {
        interceptedJobID = jobID
        return Job(id: jobID,
                   createdAt: NSDate(),
                   title: "Test job",
                   skills: ["test skill #1", "test skill #2"])

    }

    var didInvokeRefreshJob = false
    func refreshJob(job: Job) -> Job {
        didInvokeRefreshJob = true
        return job
    }
}

private final class JobDetailsInteractableDelegateSpy: JobDetailsInteractableDelegate {
    var didInvokeJobDidChange = false
    private func jobDidChange() {
        didInvokeJobDidChange = true
    }
}
