//
//  ServiceManager.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import Foundation

/* Class dedicated to the service layer */
class ServiceManager: NSObject {
    class func loadMovies (type: String, _ completionBlock : @escaping (_ responseArray:[String : Any]?, _ errorObj : NSError?)->()) {
        NetworkManger.requestForType(serviceType: ServiceType.serviceloadMovies(type: type) , params: nil) { (response, error) in
            if let error = error {
                completionBlock(nil, error)
            }else if let response = response {
                completionBlock(response, nil)
            }
        }
    }
}
