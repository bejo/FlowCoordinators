//
//  JobDetails2ViewController.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 17/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

final class JobDetails2ViewController: UIViewController {
    private let jobViewModel: JobDetailsViewModelType!
    private let router: JobDetailsRouterable

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var skillsLabel: UILabel!

    @IBAction private func refreshButtonTapped(sender: UIButton) {
        jobViewModel.refreshJob()
    }

    @IBAction private func removeButtonTapped(sender: UIButton) {
        router.showJobRemovalScreen(jobViewModel.id)
    }

    init(jobViewModel: JobDetailsViewModelType, router: JobDetailsRouterable) {
        self.jobViewModel = jobViewModel
        self.router = router
        super.init(nibName: "JobDetailsView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayJob()
    }
}

private extension JobDetails2ViewController {
    func displayJob() {
        titleLabel.text = jobViewModel.title
        dateLabel.text = jobViewModel.creationDate
        skillsLabel.text = jobViewModel.skillsList
    }
}

extension JobDetails2ViewController: JobDetailsViewModelDelegate {
    func jobDidChange() {
        displayJob()
    }
}

// MARK: Constructor
extension JobDetails2ViewController {
    static func createJobDetailsSceneWithRouter(router: JobDetailsRouterable,
                                                jobsRepository: JobsRepository,
                                                jobID: Int) -> UIViewController {
        let viewModel = JobDetailsViewModel(jobsRepository: jobsRepository, jobID: jobID)
        let jobDetailsVC = JobDetails2ViewController(jobViewModel: viewModel, router: router)
        viewModel.delegate = jobDetailsVC
        return jobDetailsVC
    }
}
