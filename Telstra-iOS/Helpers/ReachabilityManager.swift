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
}
