//
//  JobDetailsViewController.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol JobDetailsViewEventHandler {
    func removeButtonTapped()
    func refreshButtonTapped()
    func viewDidLoad()
}

protocol JobDetailsViewInterface: class {
    func displayTilte(title: String)
    func displayCreationDate(date: String)
    func displaySkills(skills: String)
}

final class JobDetailsViewController: UIViewController {
    private var eventHandler: JobDetailsViewEventHandler!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var skillsLabel: UILabel!

    @IBAction private func refreshButtonTapped(sender: UIButton) {
        self.eventHandler.refreshButtonTapped()
    }

    @IBAction private func removeButtonTapped(sender: UIButton) {
        self.eventHandler.removeButtonTapped()
    }

    override func viewDidLoad() {
        self.eventHandler.viewDidLoad()
    }
}

extension JobDetailsViewController: JobDetailsViewInterface {
    func displayTilte(title: String) {
        titleLabel.text = title
    }

    func displaySkills(skills: String) {
        skillsLabel.text = skills
    }

    func displayCreationDate(date: String) {
        dateLabel.text = date
    }
}

// MARK: Constructor
typealias JobDetailsSceneConstructor = (JobDetailsRouterable, JobsRepository, Int) -> UIViewController

extension JobDetailsViewController {
    static func createJobDetailsSceneWithRouter(router: JobDetailsRouterable,
                                                jobsRepository: JobsRepository,
                                                jobID: Int) -> UIViewController {
        let jobDetailsVC = UIStoryboard(name: "JobDetailsView", bundle: nil).instantiateInitialViewController() as! JobDetailsViewController

        let interactor = JobDetailsInteractor(jobsRepository: jobsRepository, jobID: jobID)
        let presenter = JobDetailsPresenter(router: router, interactor: interactor, view: jobDetailsVC)
        interactor.delegate = presenter
        jobDetailsVC.eventHandler = presenter

        return jobDetailsVC
    }
}
