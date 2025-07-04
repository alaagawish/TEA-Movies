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
    
    private let group = DispatchGroup()
    
    func startMonitoring() {
        group.enter()
        
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
            print("Connected:", self.isConnected)
            self.group.leave()
            self.monitor.cancel()
        }
        monitor.start(queue: queue)
    }
    
    func waitUntilChecked(completion: @escaping (Bool) -> Void) {
        group.notify(queue: .main) {
            completion(self.isConnected)
        }
    }
}

