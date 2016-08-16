//
//  JobDetailsPresenter.swift
//  FlowCoordinators
//
//  Created by Błażej Biesiada on 03/08/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

protocol JobDetailsInteractable { // The -able suffix is as an attempt to follow Swift's protocol naming conventions (Equatable, Comparable, Hashable, etc.).
    var job: Job { get }
    func refreshJob()
}

protocol JobDetailsRouterable: class {
    func showJobRemovalScreen(jobID: Int)
}

final class JobDetailsPresenter {
    private weak var router: JobDetailsRouterable? // the assumption here is that router life-time is longer than presenter lifetime, hence a weak reference to avoid retain cycles
    private let interactor: JobDetailsInteractable
    private weak var view: JobDetailsViewInterface?

    init(router: JobDetailsRouterable, interactor: JobDetailsInteractable, view: JobDetailsViewInterface) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension JobDetailsPresenter: JobDetailsViewEventHandler {
    func removeButtonTapped() {
        router?.showJobRemovalScreen(interactor.job.id)
    }

    func refreshButtonTapped() {
        interactor.refreshJob()
    }

    func viewDidLoad() {
        displayJob()
    }
}

extension JobDetailsPresenter: JobDetailsInteractorDelegate {
    func jobDidChange() {
        displayJob()
    }
}

private extension JobDetailsPresenter {
    func displayJob() {
        view?.displayTilte(interactor.job.title)
        view?.displayCreationDate(stringFromDate(interactor.job.createdAt))
        view?.displaySkills(stringFromArray(interactor.job.skills))
    }

    func stringFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter.stringFromDate(date)
    }

    func stringFromArray(array: Array<String>) -> String {
        let nsarray:NSArray = array
        return nsarray.componentsJoinedByString(", ")
    }
}
