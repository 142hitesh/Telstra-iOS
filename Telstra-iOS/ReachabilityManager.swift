//
//  RechabilityManager.swift
//  Telstra-iOS
//
//  Created by Hitesh on 7/2/18.
//  Copyright © 2018 Hitesh. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager: NSObject {
    
    var reachability: Reachability!
    
    static let sharedInstance: ReachabilityManager = { return ReachabilityManager() }()
    
    
    override init() {
        super.init()
        
        reachability = Reachability()!
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            try (ReachabilityManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    static func isReachable(completed: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection != .none {
            completed(ReachabilityManager.sharedInstance)
        }
    }
    
    static func isUnreachable(completed: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection == .none {
            completed(ReachabilityManager.sharedInstance)
        }
    }
    
    static func isReachableViaWWAN(completed: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection == .cellular {
            completed(ReachabilityManager.sharedInstance)
        }
    }
    
    static func isReachableViaWiFi(completed: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.sharedInstance.reachability).connection == .wifi {
            completed(ReachabilityManager.sharedInstance)
        }
    }
}
