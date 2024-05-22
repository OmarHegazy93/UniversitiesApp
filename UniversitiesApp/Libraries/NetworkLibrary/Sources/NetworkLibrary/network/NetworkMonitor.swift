//
//  NetworkMonitor.swift
//
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import Network

/// Singleton class to monitor network connectivity status
final class NetworkMonitor {
    /// Shared instance of `NetworkMonitor`
    static let shared = NetworkMonitor()
    
    /// Network monitor instance from `Network`
    private let monitor = NWPathMonitor()
    
    /// Dispatch queue to run the network monitor
    private let threadSafeQueue = DispatchQueue.global(qos: .background)
    
    /// Shadow property to check if the device is connected to the network
    private var _isConnected = false
    private(set) var isConnected: Bool {
        get {
            return threadSafeQueue.sync {
                _isConnected
            }
        }
        set {
            threadSafeQueue.async(flags: .barrier) { [unowned self] in
                self._isConnected = newValue
            }
        }
    }
    
    /// Private initializer to enforce singleton pattern
    private init() {
        // Set up the path update handler to update the `isConnected` status
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        // Start the monitor
        monitor.start(queue: threadSafeQueue)
    }
}


