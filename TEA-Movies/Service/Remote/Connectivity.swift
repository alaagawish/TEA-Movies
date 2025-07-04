//
//  Connectivity.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 04/07/2025.
//

import Foundation
import Network

class Connectivity {
    static let shared = Connectivity()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    public private(set) var isConnected: Bool = false
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
            print("Connected:", self.isConnected)
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

