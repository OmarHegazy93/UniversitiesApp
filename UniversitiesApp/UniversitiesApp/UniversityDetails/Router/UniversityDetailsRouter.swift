//
//  UniversityDetailsRouter.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import UIKit

// MARK: - Router

/// Protocol defining the routing logic for the University Details feature
protocol UniversityDetailsRouterProtocol: AnyObject {
    /// Creates the University Details module
    /// - Parameter university: The university model to pass to the detail view
    /// - Returns: An instance of `UniversityDetailsViewController`
    static func createModule(with university: UniversityAPIModel) -> UniversityDetailsViewController
    
    /// Dismisses the current view and refreshes the data in the list view
    func dismissAndRefreshData()
}

/// Implementation of `UniversityDetailsRouterProtocol`
final class UniversityDetailsRouter: UniversityDetailsRouterProtocol {
    /// Weak reference to the view controller to avoid retain cycles
    weak var viewController: UIViewController?
    
    /// Creates the University Details module
    /// - Parameter university: The university model to pass to the detail view
    /// - Returns: An instance of `UniversityDetailsViewController`
    static func createModule(with university: UniversityAPIModel) -> UniversityDetailsViewController {
        // Instantiate the view controller
        let view = UniversityDetailsViewController()
        
        // Set up the dependencies
        let interactor = UniversityDetailsInteractor(university: university)
        let presenter = UniversityDetailsPresenter()
        let router = UniversityDetailsRouter()
        
        // Establish the VIPER connections
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        // Return the configured view controller
        return view
    }
    
    /// Dismisses the current view and refreshes the data in the list view
    func dismissAndRefreshData() {
        if let universityListViewController = viewController?.navigationController?.viewControllers.first(where: { $0 is UniversityListViewController }) as? UniversityListViewController {
            viewController?.navigationController?.popViewController(animated: true)
            universityListViewController.refreshData()
        }
    }
}
