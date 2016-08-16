//
//  JobsRepository.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 05/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol JobsRepositoryType {
    func randomJob() -> Job
    func refreshJob(job: Job) -> Job
}

final class JobsRepository: JobsRepositoryType {
    func randomJob() -> Job {
        return Job(id: 123,
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
