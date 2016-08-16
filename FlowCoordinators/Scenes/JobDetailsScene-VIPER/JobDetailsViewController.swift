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
typealias JobDetailsSceneConstructor = (JobDetailsRouterable, JobsRepository) -> UIViewController

extension JobDetailsViewController {
    static func createJobDetailsSceneWithRouter(router: JobDetailsRouterable, jobsRepository: JobsRepository) -> UIViewController {
        let jobDetailsVC = UIStoryboard(name: "JobDetailsView", bundle: nil).instantiateInitialViewController() as! JobDetailsViewController

        let interactor = JobDetailsInteractor(jobsRepository: jobsRepository)
        let presenter = JobDetailsPresenter(router: router, interactor: interactor, view: jobDetailsVC)
        interactor.delegate = presenter
        jobDetailsVC.eventHandler = presenter

        return jobDetailsVC
    }
}
