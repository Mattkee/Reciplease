//
//  AlamofireRequestFake.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 10/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
@testable import Reciplease

class AlamofireRequestFake: AlamofireRequest {
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init()
    }
    
    override func request(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        completionHandler(data, httpResponse, error)
    }
}
