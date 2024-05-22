//
//  UniversityDetailsPresenter.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation

// MARK: - Presenter

/// Protocol defining the segregated part of the presenter to expose only the view logic
protocol UniversityDetailsPresenterViewProtocol: AnyObject {
    /// Called when the view has loaded
    func viewDidLoad()
    
    /// Called when the retry button is tapped
    func didTapRetry()
    
}

/// Protocol defining the segregated part of the presenter to expose only the interactor logic
protocol UniversityDetailsPresenterInteractorProtocol: AnyObject {
    
    /// Displays the university details
    /// - Parameter university: The university model containing the details to display
    func showUniversityDetails(_ university: UniversityAPIModel)
}

/// Protocol defining the presentation logic for the University Details feature
protocol UniversityDetailsPresenterProtocol: UniversityDetailsPresenterViewProtocol,
                                             UniversityDetailsPresenterInteractorProtocol {
    /// The view associated with the presenter
    var view: UniversityDetailsViewProtocol? { get set }
    
    /// The interactor associated with the presenter
    var interactor: UniversityDetailsInteractorProtocol? { get set }
    
    /// The router associated with the presenter
    var router: UniversityDetailsRouterProtocol? { get set }
    
}

/// Implementation of `UniversityDetailsPresenterProtocol`
final class UniversityDetailsPresenter: UniversityDetailsPresenterProtocol {
    /// Weak reference to the view to avoid retain cycles
    weak var view: UniversityDetailsViewProtocol?
    
    var interactor: UniversityDetailsInteractorProtocol?
    var router: UniversityDetailsRouterProtocol?
    
    /// Called when the view has loaded
    func viewDidLoad() {
        interactor?.fetchUniversityDetails()
    }
    
    /// Called when the retry button is tapped
    func didTapRetry() {
        router?.dismissAndRefreshData()
    }
    
    /// Displays the university details
    /// - Parameter university: The university model containing the details to display
    func showUniversityDetails(_ university: UniversityAPIModel) {
        view?.showUniversityDetails(university)
    }
}

