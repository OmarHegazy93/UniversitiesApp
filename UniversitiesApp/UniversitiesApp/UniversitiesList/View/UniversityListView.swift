//
//  UniversityListView.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import UIKit

// MARK: - View Protocol

/// Protocol defining the view interface for the University List feature
protocol UniversityListViewProtocol: AnyObject {
    /// Displays the list of universities
    /// - Parameter universities: The array of `UniversityAPIModel` to display
    func showUniversities(_ universities: [UniversityAPIModel])
    
    /// Displays an error message
    /// - Parameter error: The error message to display
    func showError(_ error: String)
}

// MARK: - View Controller

/// View controller for displaying the list of universities
final class UniversityListViewController: UIViewController, UniversityListViewProtocol {
    /// The presenter associated with the view
    var presenter: UniversityListPresenterViewProtocol?
    
    /// The array of universities to display
    private var universities: [UniversityAPIModel] = []
    
    /// The table view for displaying the universities
    private let tableView = UITableView()
    
    /// The loading indicator for showing a loading state
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    /// Called after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    /// Sets up the UI components
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// Shows the loading indicator and hides the table view
    func showLoader() {
        self.loadingIndicator.startAnimating()
        self.tableView.isHidden = true
    }
    
    /// Hides the loading indicator and shows the table view
    func hideLoader() {
        self.loadingIndicator.stopAnimating()
        self.tableView.isHidden = false
    }
    
    /// Refreshes the data by showing the loader and requesting the presenter to refresh data
    func refreshData() {
        showLoader()
        presenter?.refreshData()
    }
    
    /// Displays the list of universities
    /// - Parameter universities: The array of `UniversityAPIModel` to display
    func showUniversities(_ universities: [UniversityAPIModel]) {
        self.universities = universities
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoader()
        }
    }
    
    /// Displays an error message
    /// - Parameter error: The error message to display
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.universities.removeAll()
            self.tableView.reloadData()
            self.hideLoader()
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Table View Delegate and Data Source

extension UniversityListViewController: UITableViewDelegate, UITableViewDataSource {
    /// Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    /// Configures the cell for the specified index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = universities[indexPath.row].name
        return cell
    }
    
    /// Called when a row is selected in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUniversity = universities[indexPath.row]
        presenter?.didSelectUniversity(selectedUniversity)
    }
}
