//
//  JobDetailsViewController.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol JobDetailsViewEventHandler { // This protocol could be named JobDetailsPresenterInterface, but I wanted to make JobDetailsViewController independent from the rest of the VIPER stack. 
    func removeButtonTapped()
    func refreshButtonTapped()
}

protocol JobDetailsViewInterface: class {
    func displayJobTilte(title: String)
}

final class JobDetailsViewController: UIViewController {
    var eventHandler: JobDetailsViewEventHandler!

    @IBOutlet private weak var titleLabel: UILabel!

    @IBAction private func refreshButtonTapped(sender: UIButton) {
        self.eventHandler.refreshButtonTapped()
    }

    @IBAction func removeButtonTapped(sender: UIButton) {
        self.eventHandler.removeButtonTapped()
    }
}

extension JobDetailsViewController: JobDetailsViewInterface {
    func displayJobTilte(title: String) {
        titleLabel.text = title
    }
}

// MARK: Constructor
typealias JobDetailsSceneConstructor = (JobDetailsRouterable, JobsRepository) -> UIViewController

extension JobDetailsViewController {
    static func createJobDetailsSceneWithRouter(router: JobDetailsRouterable, jobsRepository: JobsRepository) -> UIViewController {
        let jobDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! JobDetailsViewController

        let interactor = JobDetailsInteractor(jobsRepository: jobsRepository)
        let presenter = JobDetailsPresenter(router: router, interactor: interactor, view: jobDetailsVC)
        interactor.delegate = presenter
        jobDetailsVC.eventHandler = presenter

        return jobDetailsVC
    }
}
