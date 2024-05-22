//
//  UniversityListPresenter.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation

// MARK: - Presenter

/// Protocol defining the segregated part of the presenter to expose only the interactor logic
protocol UniversityListPresenterInteractorProtocol: AnyObject {
    /// Called when universities are fetched successfully
    /// - Parameter universities: The array of fetched universities
    func universitiesFetchedSuccessfully(universities: [UniversityAPIModel])
    
    /// Called when fetching universities fails
    /// - Parameter error: The error message
    func universitiesFetchingFailed(with error: String)
}

/// Protocol defining the segregated part of the presenter to expose only the interactor logic
protocol UniversityListPresenterViewProtocol: AnyObject {
    /// Called when the view has loaded
    func viewDidLoad()
    
    /// Called to refresh the data
    func refreshData()
    
    /// Called when a university is selected
    /// - Parameter university: The selected university model
    func didSelectUniversity(_ university: UniversityAPIModel)

}

/// Protocol defining the presentation logic for the University List feature
protocol UniversityListPresenterProtocol: UniversityListPresenterInteractorProtocol,
                                          UniversityListPresenterViewProtocol {
    /// The view associated with the presenter
    var view: UniversityListViewProtocol? { get set }
    /// The interactor associated with the presenter
    var interactor: UniversityListInteractorProtocol? { get set }
    /// The router associated with the presenter
    var router: UniversityListRouterProtocol? { get set }
}

/// Implementation of `UniversityListPresenterProtocol`
final class UniversityListPresenter: UniversityListPresenterProtocol {
    /// Weak reference to the view to avoid retain cycles
    weak var view: UniversityListViewProtocol?
    var interactor: UniversityListInteractorProtocol?
    var router: UniversityListRouterProtocol?
    
    /// Called when the view has loaded
    func viewDidLoad() {
        interactor?.fetchUniversities()
    }
    
    /// Called to refresh the data
    func refreshData() {
        interactor?.refreshData()
    }
    
    /// Called when a university is selected
    /// - Parameter university: The selected university model
    func didSelectUniversity(_ university: UniversityAPIModel) {
        router?.navigateToDetail(with: university)
    }
    
    /// Called when universities are fetched successfully
    /// - Parameter universities: The array of fetched universities
    func universitiesFetchedSuccessfully(universities: [UniversityAPIModel]) {
        view?.showUniversities(universities)
    }
    
    /// Called when fetching universities fails
    /// - Parameter error: The error message
    func universitiesFetchingFailed(with error: String) {
        view?.showError(error)
    }
}
