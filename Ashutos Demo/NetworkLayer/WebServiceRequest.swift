//
//  WebServiceRequest.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import UIKit

extension WebService{
    func imageDetails( block : @escaping WSCompletionBlock){
        let service = WebServiceToGetImageList(manager : self, block : block)
        self.startRequest(service: service)
    }
}
