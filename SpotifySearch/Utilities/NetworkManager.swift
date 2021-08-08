//
//  NetworkManager.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnect = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.isConnect = path.status  == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
