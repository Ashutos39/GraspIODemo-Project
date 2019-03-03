//
//  WebServiceToGetImageList.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import Alamofire

class WebServiceToGetImageList : WebServiceRequest{

    override init(manager : WebService, block : @escaping WSCompletionBlock) {
        super.init(manager : manager, block: block)
        httpMethod = HTTPMethod.get
        url = manager.URL

    }

    override func responseSuccess(data : Any?) {
        if let dataArray = data as? [[String : AnyObject]] {
            var dataForDBinsert = [[String: AnyObject]]()
            var dataDictForInsersion = [String:Any]()
            for i in dataArray {
                let indiArray = i
                let url = indiArray["url"] as! String
                let id = indiArray["id"] as! String
                var desc = ""
                let bread = indiArray["breeds"] as! [[String:Any]]
                if bread.count != 0{
                    let data = bread[0] as [String:AnyObject]
                    desc = data["description"] as! String
                }
                dataDictForInsersion["id"] = id
                dataDictForInsersion["imageUrl"] = url
                dataDictForInsersion["desc"] = desc
                dataForDBinsert.append(dataDictForInsersion as [String : AnyObject])
            }
            AllImageDetails.insertToDbWithImageDatails(indiImageArray: dataForDBinsert)
        }
        super.responseSuccess(data: data)
    }


}
