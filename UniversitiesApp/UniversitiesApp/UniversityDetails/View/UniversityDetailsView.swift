//
//  UniversityDetailsView.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import UIKit

// MARK: - View

/// Protocol defining the view interface for the University Details feature
protocol UniversityDetailsViewProtocol: AnyObject {
    /// Displays the university details
    /// - Parameter university: The university model containing the details to display
    func showUniversityDetails(_ university: UniversityAPIModel)
}

/// View controller for displaying the details of a university
final class UniversityDetailsViewController: UIViewController, UniversityDetailsViewProtocol {
    /// The presenter associated with the view
    var presenter: UniversityDetailsPresenterViewProtocol?
    
    /// The university model containing the details to display
    private var university: UniversityAPIModel?
    
    /// UI elements for displaying university details
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()
    private let domainLabel = UILabel()
    
    /// Called after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    /// Sets up the UI components
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add UI elements to the view
        view.addSubview(nameLabel)
        view.addSubview(countryLabel)
        view.addSubview(domainLabel)
        
        // Configure layout constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        domainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            domainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            domainLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
        ])
        
        // Add refresh button to the navigation bar
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRetry))
        navigationItem.rightBarButtonItem = refreshButton
        
        // Set initial state for animation
        nameLabel.alpha = 0
        countryLabel.alpha = 0
        domainLabel.alpha = 0
    }
    
    /// Called when the retry button is tapped
    @objc private func didTapRetry() {
        presenter?.didTapRetry()
    }
    
    /// Displays the university details
    /// - Parameter university: The university model containing the details to display
    func showUniversityDetails(_ university: UniversityAPIModel) {
        DispatchQueue.main.async {
            self.university = university
            self.nameLabel.text = university.name
            self.countryLabel.text = university.country
            self.domainLabel.text = university.domains.joined(separator: ", ")
        }
        
        // Animate the labels
        UIView.animate(withDuration: 0.5) {
            self.nameLabel.alpha = 1
            self.countryLabel.alpha = 1
            self.domainLabel.alpha = 1
        }
    }
}
