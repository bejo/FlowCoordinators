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
    private var delegateSpy: JobDetailsInteractorDelegateSpy!

    override func setUp() {
        super.setUp()
        jobsRepoSpy = JobsRepositorySpy()
        delegateSpy = JobDetailsInteractorDelegateSpy()
        sut = JobDetailsInteractor(jobsRepository: jobsRepoSpy)
        sut.delegate = delegateSpy
    }

    func testInitialJob() {
        let job = sut.job

        XCTAssertEqual(job.id, 123, "Job ID should be equal to the mocked value.")
        XCTAssertTrue(jobsRepoSpy.didInvokeRandomJob, "Interactor should ask repo for a random job.")
    }
    
    func testJobRefresh() {
        sut.refreshJob()

        XCTAssertTrue(jobsRepoSpy.didInvokeRefreshJob, "Interactor should ask repo to refresh a job.")
        XCTAssertTrue(delegateSpy.didInvokeJobDidChange, "Interactor should tell delegate that a job changed.")
    }
}

private final class JobsRepositorySpy: JobsRepositoryType {
    var didInvokeRandomJob = false
    func randomJob() -> Job {
        didInvokeRandomJob = true
        return Job(id: 123,
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

private final class JobDetailsInteractorDelegateSpy: JobDetailsInteractorDelegate {
    var didInvokeJobDidChange = false
    private func jobDidChange() {
        didInvokeJobDidChange = true
    }
}
