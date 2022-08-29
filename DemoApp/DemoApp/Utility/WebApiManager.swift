//
//  WebAPIManager.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import UIKit
import Alamofire
import Foundation

class WebAPIManager: NSObject {
    
    class var  shared: WebAPIManager {
        struct Static {
            static var instance : WebAPIManager? = nil
        }
        if !(Static.instance != nil) {
            Static.instance = WebAPIManager()
        }
        return Static.instance!
    }
    
    func callWebService(serviceName: String, method: HTTPMethod = .post, parameter: [String : Any], success: @escaping (_ data: Data) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        if NetworkManager.isNetworkAvailable() {
            CommonUtility.startLoader()
            let serviceURL = SERVER_URL + serviceName
            AF.request(serviceURL, method: method, parameters: parameter).validate().responseData { response in
                DispatchQueue.main.async {
                    CommonUtility.stopLoader()
                }
                switch response.result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    failure(error as NSError?)
                }
            }
        } else {
            CommonUtility.showAlertMessage(message: MSG_NETWORK_ERROR, title: APP_NAME)
        }
    }
}
