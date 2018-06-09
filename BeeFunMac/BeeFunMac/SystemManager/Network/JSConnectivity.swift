//
//  JSReachability.swift
//  BeeFun
//
//  Created by WengHengcong on 27/06/2017.
//  Copyright © 2017 JungleSong. All rights reserved.
//

import Cocoa
import Alamofire

class JSConnectivity {
    
    static var reachablityManager = NetworkReachabilityManager()
    
    class var isConnectdToInternet: Bool {
        return reachablityManager!.isReachable
    }
    
    class var isWifi: Bool {
        return reachablityManager!.isReachableOnEthernetOrWiFi
    }
    
    class var isWWAN: Bool {
        return reachablityManager!.isReachableOnWWAN
    }
    
   class func startNetworkReachabilityObserver() {
        reachablityManager?.listener = { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                
            }
        }
        // start listening
        reachablityManager!.startListening()
    }
    
}
