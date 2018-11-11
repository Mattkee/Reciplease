//
//  HTTPTask.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 09/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

// MARK: - Manages some type of request
public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
}
