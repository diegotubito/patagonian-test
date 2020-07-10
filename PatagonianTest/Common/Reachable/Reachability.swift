//
//  Reachability.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import SystemConfiguration
import Alamofire

extension Notification.Name {
    public static let Reachable = Notification.Name(rawValue: "Reachability.Reachable")
    public static let NotReachable = Notification.Name(rawValue: "Reachability.NotReachable")
}

class Reachability: NSObject {
    static let shared = Reachability()
    
    public func suscribeConnectionChanged() {
        let net = NetworkReachabilityManager()
        net?.startListening(onUpdatePerforming: { (status) in
            if net?.isReachable ?? false {
                switch status {
                case .reachable(.ethernetOrWiFi):
                    print("wifi connection")
                    NotificationCenter.default.post(name: Notification.Name.Reachable, object: nil)
                case .reachable(.cellular):
                    print("cellular connection")
                    NotificationCenter.default.post(name: Notification.Name.Reachable, object: nil)
                case .notReachable:
                    print("not reachable")
                    NotificationCenter.default.post(name: Notification.Name.NotReachable, object: nil)
                case .unknown :
                    print("It is unknown whether the network is reachable")
                }
            }
            else {
                print("The network is not reachable")
                NotificationCenter.default.post(name: Notification.Name.NotReachable, object: nil)
            }
        })
    }
    
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    public func isConnectedToWifi() -> Bool {
        if Reachability.shared.isConnectedToNetwork() {
            if let net = NetworkReachabilityManager() {
                if net.isReachableOnEthernetOrWiFi {
                    return true
                }
            }
        }
        
        return false
    }

}

