# University Explorer App

## Overview

The University Explorer App is designed to help users explore universities around the world. The app fetches data from a remote API and displays a list of universities based on user preferences. Users can view detailed information about each university and save their favorite universities for offline access. The app also monitors network connectivity to ensure a smooth user experience.

## Features

1. **Fetch Universities**: Retrieve a list of universities from a remote API based on a specified country.
2. **Display University Details**: View detailed information about selected universities, including their name, country, domains, and web pages.
3. **Offline Access**: Save university data locally to access it even when offline.
4. **Network Monitoring**: Monitor network connectivity to handle network status changes gracefully.
5. **Retry Mechanism**: Allow users to retry fetching data if the initial request fails due to network issues.

## Components

### 1. Network Layer

- **APIManager**: Handles network requests and manages URL sessions.
- **RequestManager**: Performs network requests and parses the response.
- **NetworkError**: Enum representing possible network errors.
- **NetworkMonitor**: Singleton class to monitor network connectivity status.

### 2. Data Models

- **UniversityAPIModel**: Codable model representing a university fetched from the API.
- **UniversityPersistenceModel**: Realm object model representing a university for persistence.

### 3. Database Layer

- **DatabaseService**: Protocol defining CRUD operations for the database.
- **RealmDatabaseService**: Implementation of DatabaseService using Realm.
- **DataParser**: Parses JSON data into decodable objects.

### 4. VIPER Architecture

#### a. View

- **UniversityListViewProtocol**: Protocol defining the view interface for the university list.
- **UniversityListViewController**: View controller displaying the list of universities.
- **UniversityDetailsViewProtocol**: Protocol defining the view interface for university details.
- **UniversityDetailsViewController**: View controller displaying details of a selected university.

#### b. Interactor

- **UniversityListInteractorProtocol**: Protocol defining the interactor interface for the university list.
- **UniversityListInteractor**: Interactor handling business logic for the university list.
- **UniversityDetailsInteractorProtocol**: Protocol defining the interactor interface for university details.
- **UniversityDetailsInteractor**: Interactor handling business logic for university details.

#### c. Presenter

- **UniversityListPresenterProtocol**: Protocol defining the presentation logic for the university list.
- **UniversityListPresenter**: Presenter handling presentation logic for the university list.
- **UniversityDetailsPresenterProtocol**: Protocol defining the presentation logic for university details.
- **UniversityDetailsPresenter**: Presenter handling presentation logic for university details.

#### d. Router

- **UniversityListRouterProtocol**: Protocol defining the routing logic for the university list.
- **UniversityListRouter**: Router handling navigation for the university list.
- **UniversityDetailsRouterProtocol**: Protocol defining the routing logic for university details.
- **UniversityDetailsRouter**: Router handling navigation for university details.

### 5. Repository Layer

- **UniversityRepositoryProtocol**: Protocol defining the repository interface for fetching universities.
- **UniversityRepository**: Repository handling data operations for universities.

## Usage

To use this app, follow these steps:

1. **Set Up the Project**: Clone the repository and open the project in Xcode.
2. **Run the App**: Build and run the app on a simulator or a physical device.
3. **Fetch Universities**: Select a country to fetch universities from the remote API.
4. **View Details**: Tap on a university to view detailed information.
5. **Offline Access**: Save your favorite universities for offline access.
6. **Monitor Connectivity**: The app will automatically monitor network connectivity and handle changes gracefully.

## Example

```swift
let requestManager = RequestManager()
let repository = UniversityRepository(networkManager: requestManager)
let interactor = UniversityListInteractor(repository: repository)
let presenter = UniversityListPresenter()
let router = UniversityListRouter()

let view = UniversityListViewController()
view.presenter = presenter
presenter.view = view
presenter.interactor = interactor
presenter.router = router
interactor.presenter = presenter
router.viewController = view

window.rootViewController = UINavigationController(rootViewController: view)
window.makeKeyAndVisible()
