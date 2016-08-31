//
//  JobDetailsInteractor.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol JobDetailsInteractable {
    var job: Job { get }
    func refreshJob()
}

protocol JobDetailsInteractableDelegate: class {
    func jobDidChange()
}

final class JobDetailsInteractor: JobDetailsInteractable {
    private let jobsRepository: JobsRepositoryType
    weak var delegate: JobDetailsInteractableDelegate?

    var job: Job {
        didSet {
            self.delegate?.jobDidChange()
        }
    }

    init(jobsRepository: JobsRepositoryType, jobID: Int)  {
        self.jobsRepository = jobsRepository
        self.job = jobsRepository.jobWithID(jobID)
    }

    func refreshJob() {
        job = jobsRepository.refreshJob(job)
    }
}
