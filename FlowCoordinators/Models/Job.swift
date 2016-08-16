//
//  Job.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

struct Job {
    let id: Int
    let createdAt: NSDate
    let title: String
    let skills: Set<String>
}
