//
//  JobsRepository.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 05/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol JobsRepositoryType {
    func jobWithID(jobID: Int) -> Job
    func refreshJob(job: Job) -> Job
}

final class JobsRepository: JobsRepositoryType {
    func jobWithID(jobID: Int) -> Job {
        return Job(id: jobID,
                   createdAt: NSDate(),
                   title: "iOS Developer",
                   skills: ["Objective-C", "Swift", "Xcode"])
    }

    func refreshJob(job: Job) -> Job {
        return Job(id: job.id,
                   createdAt: job.createdAt,
                   title: "iOS Engineer",
                   skills: job.skills)
    }
}
