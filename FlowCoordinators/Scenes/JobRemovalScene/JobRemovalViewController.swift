//
//  JobRemovalViewController.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 05/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol JobRemovalViewDelegate: class {
    func dismissButtonTapped()
}

/**
 A sample scene implemented using pure MVC pattern. It's MVC just to show that
 flow coordinators don't depends on scenes architecture. That is true as long as
 we use a subclass of UIViewController as a scene main interface.
 */
final class JobRemovalViewController: UIViewController {
    weak var delegate: JobRemovalViewDelegate?

    @IBAction func dismissButtonTapped(sender: AnyObject) {
        delegate?.dismissButtonTapped()
    }
}

// MARK: Constructor
typealias JobRemovalSceneConstructor = (JobRemovalViewDelegate) -> UIViewController

extension JobRemovalViewController {
    static func createJobRemovalSceneWithEventHandler(handler: JobRemovalViewDelegate) -> UIViewController {
        let jobRemovalVC = UIStoryboard(name: "JobRemovalView", bundle: nil).instantiateInitialViewController() as! JobRemovalViewController
        jobRemovalVC.delegate = handler
        return jobRemovalVC
    }
}
