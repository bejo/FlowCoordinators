//
//  JobDetailsViewController.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

protocol JobDetailsViewableDelegate {
    func removeButtonTapped()
    func refreshButtonTapped()
    func viewDidLoad()
}

protocol JobDetailsViewable: class {
    func displayTilte(title: String)
    func displayCreationDate(date: String)
    func displaySkills(skills: String)
}

final class JobDetailsViewController: UIViewController {
    private var delegate: JobDetailsViewableDelegate!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var skillsLabel: UILabel!

    @IBAction private func refreshButtonTapped(sender: UIButton) {
        self.delegate.refreshButtonTapped()
    }

    @IBAction private func removeButtonTapped(sender: UIButton) {
        self.delegate.removeButtonTapped()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate.viewDidLoad()
    }
}

extension JobDetailsViewController: JobDetailsViewable {
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
extension JobDetailsViewController {
    static func createJobDetailsSceneWithRouter(router: JobDetailsRouterable,
                                                jobsRepository: JobsRepository,
                                                jobID: Int) -> UIViewController {
        let jobDetailsVC = UIStoryboard(name: "JobDetailsView", bundle: nil).instantiateInitialViewController() as! JobDetailsViewController

        let interactor = JobDetailsInteractor(jobsRepository: jobsRepository, jobID: jobID)
        let presenter = JobDetailsPresenter(router: router, interactor: interactor, view: jobDetailsVC)
        interactor.delegate = presenter
        jobDetailsVC.delegate = presenter

        return jobDetailsVC
    }
}
