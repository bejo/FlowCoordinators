//
//  SceneType.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 18/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

/**
 It's impossible to define a protocol that inherits `UIViewController`
 interface. Therefore, it's also impossible to say that an object
 depends on `UIViewController` and some protocol at the same time.
 
 Here comes `SceneType` which exists to allow testing objects which
 depend on view controllers (subclasses).
*/
protocol SceneType {
    var viewController: UIViewController { get }
}

extension SceneType where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
