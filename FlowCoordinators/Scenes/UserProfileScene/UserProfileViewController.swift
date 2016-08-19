//
//  UserProfileViewController.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol UserProfileSceneType: SceneType {

}

class UserProfileViewController: UIViewController, UserProfileSceneType {
}

// MARK: Constructor
typealias UserProfileSceneConstructor = (UserRepositoryType) -> UserProfileSceneType

extension UserProfileViewController {
    static func createUserProfileSceneWithUserRepo(repo: UserRepositoryType) -> UserProfileViewController {
        return UserProfileViewController()
    }
}
