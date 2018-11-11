//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 09/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}
