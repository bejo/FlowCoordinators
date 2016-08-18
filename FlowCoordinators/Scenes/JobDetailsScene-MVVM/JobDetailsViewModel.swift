//
//  JobDetailsViewModel.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol JobDetailsViewModelType {
    var id: Int { get }
    var title: String { get }
    var creationDate: String { get }
    var skillsList: String { get }
    func refreshJob()
}

protocol JobDetailsViewModelDelegate: class {
    func jobDidChange()
}

final class JobDetailsViewModel: JobDetailsViewModelType {
    private let jobsRepository: JobsRepositoryType
    weak var delegate: JobDetailsViewModelDelegate?

    private var job: Job {
        didSet {
            delegate?.jobDidChange()
        }
    }

    init(jobsRepository: JobsRepositoryType, jobID: Int)  {
        self.jobsRepository = jobsRepository
        self.job = jobsRepository.jobWithID(jobID)
    }

    var id: Int {
        return job.id
    }

    var title: String {
        return job.title
    }

    var creationDate: String {
        return stringFromDate(job.createdAt)
    }

    var skillsList: String {
        return stringFromArray(job.skills)
    }

    func refreshJob() {
        job = jobsRepository.refreshJob(job)
    }
}

private extension JobDetailsViewModel {
    func stringFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter.stringFromDate(date)
    }

    func stringFromArray(array: Array<String>) -> String {
        let nsarray:NSArray = array
        return nsarray.componentsJoinedByString(", ")
    }
}
