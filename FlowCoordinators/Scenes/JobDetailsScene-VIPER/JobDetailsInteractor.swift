//
//  JobDetailsInteractor.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol JobDetailsInteractorDelegate: class {
    func jobDidChange()
}

final class JobDetailsInteractor: JobDetailsInteractable {
    private let jobsRepository: JobsRepository
    weak var delegate: JobDetailsInteractorDelegate?

    var job: Job {
        didSet {
            self.delegate?.jobDidChange()
        }
    }

    init(jobsRepository: JobsRepository)  {
        self.jobsRepository = jobsRepository
        self.job = jobsRepository.randomJob()
    }

    func refreshJob() {
        jobsRepository.refreshJob(job)
    }
}
