//
//  File.swift
//
//
//  Created by Дмитрий Яровой on 12/30/22.
//

import Foundation
import Network
import Combine
 
public final class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
     
    @Published public var isNotConnected = false
    let isNotConnectedSub = PassthroughSubject<Bool, Never>()
     
    public init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                let flag = path.status == .satisfied ? false : true
                self?.isNotConnected = flag
                self?.isNotConnectedSub.send(flag)
            }
        }
        monitor.start(queue: queue)
    }
}
