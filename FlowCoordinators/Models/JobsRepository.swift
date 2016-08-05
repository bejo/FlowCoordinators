//
//  JobsRepository.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 05/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

final class JobsRepository {
    func randomJob() -> Job {
        return Job(id: 123, title: "iOS Developer")
    }

    func refreshJob(job: Job) -> Job {
        return Job(id: job.id, title: "iOS Engineer")
    }
}
