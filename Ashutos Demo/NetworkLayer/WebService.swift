//
//  WebService.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import Alamofire

class WebService: NSObject {
    var serviceArray = [WebServiceRequest]()
    static let sharedService : WebService = {
        let instance = WebService()
        return instance
    }()

    let URL = "https://api.thecatapi.com/v1/images/search?size=full&mime_types=jpg&format=json&order=RANDOM&page=0&limit=100&category_ids=&breed_ids="

    private override init() {
    }

    func startRequest(service : WebServiceRequest){
        service.start()
        serviceArray.append(service)
        print("services started = \(self.serviceArray.count)")
    }

    func stopRequest(service : WebServiceRequest){
        service.stop()
    }

    func closeService(service : WebServiceRequest?){
        guard service != nil else{
            return
        }
        if self.serviceArray.contains(service!) == true{
            self.serviceArray.remove(at: serviceArray.index(of: service!)!)
        }
        print("service pending = \(self.serviceArray.count)")
    }

    func cancelAllRequests(){

        for service in self.serviceArray {
            self.stopRequest(service: service)
        }
        print("service pending = \(self.serviceArray.count)")
        self.serviceArray.removeAll()
    }
}
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
