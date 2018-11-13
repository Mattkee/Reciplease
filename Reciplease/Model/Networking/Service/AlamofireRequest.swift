//
//  AlamofireRequest.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 10/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequest {
    func request(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            let data = responseData.data
            let response = responseData.response
            let error = responseData.error
            
            completionHandler(data, response, error)
        }
    }
}
