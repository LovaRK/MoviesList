//
//  NetworkManger.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import Foundation
import Alamofire


/* Class dedicated to the Network layer */

enum ServiceType: URLConvertible{
    
    case serviceloadMovies(type: String)//Add more calls later
    
    func asURL() throws -> URL {
        return URL.init(string: self.URLString)!
    }
    //TODO : ADD UR LCONSTANTS FILE
    var URLString : String{
        switch self{
        case .serviceloadMovies(let type):
            print("https://api.themoviedb.org/3/movie/\(type)?api_key=4fafde19e120ff8f6ef8e1106f0e614c")
            return String(format: "https://api.themoviedb.org/3/movie/\(type)?api_key=4fafde19e120ff8f6ef8e1106f0e614c")
        }
    }
    var requestMethod : Alamofire.HTTPMethod{
        switch self{
        case .serviceloadMovies:
            return .get
            //Add more when required
            //        default: //for future use - delete the default to suppress the warning
            //            return .get
        }
    }
    var headers:[String : String]{
        switch self{
        case .serviceloadMovies:
            var values = ["Content-Type": "application/json"]
            values ["Accept-Encoding"] = "gzip"
            return values
            //Add more when required
            //                default:
            //            var values = ["Content-Type": "application/json"]
            //            values ["Accept-Encoding"] = "gzip"
            //            return values
        }
    }
}

class NetworkManger: NSObject {
    //not for v6 - need to handle differently for v6
    class func requestForType(serviceType : ServiceType, params:[String: Any]?, completionBlock :@escaping (_ response:[String : Any]?,_ error: NSError?) -> ()) {
        //TODO:CHECK FOR NETWORK CONNECTION USING REACHABILITY
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        Alamofire.request(serviceType.URLString, method: serviceType.requestMethod, parameters: params, encoding: URLEncoding.default, headers: serviceType.headers).responseJSON{ response in
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(response)
                switch response.result{
                case .success(let value):
                    if value is NSNull{
                        // SERVER MESS - SENDING NOTHING INSIDE SUCCESS
                        completionBlock([String : Any](), nil)
                        return
                    }
                    let responseValue = value as? [String : AnyObject]
                    completionBlock(responseValue, nil)
                case .failure(let error):
                    if (response.response?.statusCode == 304){
                        completionBlock([String : Any](), nil)
                    }else{
                        print(Error.self)
                        completionBlock(nil, error as NSError)
                        if error.localizedDescription == "cancelled" {
                        } else {
                            DispatchQueue.main.async() {
                                //Show aleart to the user
                            }
                        }
                    }
                }
            }
        }
    }    
}

