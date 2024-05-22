//
//  UniversityListRouter.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import UIKit

// MARK: - Router

/// Protocol defining the routing logic for the University List feature
protocol UniversityListRouterProtocol: AnyObject {
    /// Creates the University List module
    /// - Returns: An instance of `UniversityListViewController`
    static func createModule() -> UniversityListViewController
    
    /// Navigates to the detail view with the selected university
    /// - Parameter university: The university model to pass to the detail view
    func navigateToDetail(with university: UniversityAPIModel)
}

/// Implementation of `UniversityListRouterProtocol`
final class UniversityListRouter: UniversityListRouterProtocol {
    /// Weak reference to the view controller to avoid retain cycles
    weak var viewController: UIViewController?
    
    /// Creates the University List module
    /// - Returns: An instance of `UniversityListViewController`
    static func createModule() -> UniversityListViewController {
        // Instantiate the view controller
        let view = UniversityListViewController()
        
        // Set up the dependencies
        let repository = UniversityRepository()
        let interactor = UniversityListInteractor(repository: repository)
        let presenter = UniversityListPresenter()
        let router = UniversityListRouter()
        
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
    
    /// Navigates to the detail view with the selected university
    /// - Parameter university: The university model to pass to the detail view
    func navigateToDetail(with university: UniversityAPIModel) {
        // Create the detail view module
        let detailViewController = UniversityDetailsRouter.createModule(with: university)
        // Push the detail view controller onto the navigation stack
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
