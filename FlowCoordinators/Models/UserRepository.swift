//
//  UserRepository.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol UserRepositoryType {
    var user: User { get }
}

final class UserRepository: UserRepositoryType {
    var user: User {
        get {
            return User(id: 1,
                        createdAt: NSDate(),
                        name: "Steve Wozniak")
        }
    }
}
