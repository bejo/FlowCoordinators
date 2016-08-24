//
//  ViewControllerSpy.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 24/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

final class ViewControllerSpy: UIViewController {
    var interceptedViewControllerToPresent: UIViewController? = nil
    override func presentViewController(viewControllerToPresent: UIViewController,
                                        animated flag: Bool,
                                                 completion: (() -> Void)?) {
        interceptedViewControllerToPresent = viewControllerToPresent
    }
}
