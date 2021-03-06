//
//  WebServiceRequestHeadClass.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import Alamofire

typealias WSCompletionBlock = (_ object : Any?, _ error : Error?) -> Void

class WebServiceRequest: NSObject {

    var block : WSCompletionBlock

    var url : String?

    var httpMethod : HTTPMethod = .get

    var headers : HTTPHeaders? = [String : String]()

    var body : Parameters? = Parameters()

    var request : DataRequest?

    weak var manager : WebService?

    let concurrentQueue = DispatchQueue(label: "userqueue", attributes: .concurrent)

    init(manager : WebService, block : @escaping WSCompletionBlock) {
        self.block = block
        self.manager = manager
    }

    func start(){

        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil

        headers?["Content-Type"] = "application/json"
        headers?["x-api-key"] = "a1495b76-ad05-49d6-8840-d71bdc166145"

        _ = Alamofire.SessionManager(configuration: configuration)

        if httpMethod == HTTPMethod.post {
            self.request = Alamofire.request(url!, method: httpMethod, parameters: body, encoding: JSONEncoding(), headers: headers).validate(statusCode: 200...300)
        }else{
            self.request = Alamofire.request(url!, method: httpMethod, parameters: body, encoding: URLEncoding.httpBody, headers: headers).validate(statusCode: 200...300)
        }

        print("################# REQUEST ################## \n \(httpMethod) url = \(url) \n\n headers = \(headers) \n\n body = \(body)  \n\n\n\n")

        let requestDetail = "REQUEST: \n \(httpMethod) url = \(url) \n\n headers = \(headers) \n\n body = \(body)  \n\n\n\n"
        self.request?.responseJSON(completionHandler: { (response) in
            if let error = response.result.error {
                var validatedError = response.data?.validateError(errorcode: (error as! NSError).code)
                if validatedError == nil{
                    validatedError = error as? NSError
                }

                let errorMesssage:String = { if let errorMsg = validatedError?.message(){
                    return errorMsg
                } else {
                    return ""
                    }
                }()

                let code:Int = (error as NSError).code
                let codeStr = String(code)


                self.responseFailed(data: response.data, responseError: error)
                return
            }

            let attributeDict = response.result.value
            self.responseSuccess(data: attributeDict)

        })
    }

    func stop(){

        if let request = self.request{
            request.cancel()
        }
    }

    func responseSuccess(data : Any?){
        DispatchQueue.main.async {
            self.block(data,nil)
        }
        WebService.sharedService.closeService(service: self)
    }

    func responseFailed(data : Data?, responseError : Error?){
        var error = data?.validateError(errorcode: (responseError as! NSError).code)
        if error == nil{
            error = responseError as? NSError
        }
        DispatchQueue.main.async {
            self.block(nil,error)
        }
        WebService.sharedService.closeService(service: self)
    }

}

extension Data{

    func validateError(errorcode : Int) -> NSError?{
        var json : [String : Any]?
        do{
            json = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
            let errors = json?["errors"] as? [[String : Any]]
            if let errors = errors{
                for item in errors {
                    if item["code"] != nil{
                        //let code = Int(item["code"] as! String)
                        let message = item["message"] as! String
                        let error = NSError(domain: "", code: errorcode, userInfo: ["message" : message])
                        return error
                    }
                }
            }
        } catch {
            return nil
        }
        return nil
    }
}
