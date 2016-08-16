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
}

extension JobDetailsPresenter: JobDetailsInteractorDelegate {
    func jobDidChange() {
        view?.displayTilte(interactor.job.title)
        view?.displayCreationDate(stringFromDate(interactor.job.createdAt))
        view?.displaySkills(stringFromSet(interactor.job.skills))
    }
}

private extension JobDetailsPresenter {
    func stringFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter.stringFromDate(date)
    }

    func stringFromSet(set: Set<String>) -> String {
        let array:NSArray = Array(set)
        return array.componentsJoinedByString(",")
    }
}
