//
//  Parameter.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 05/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

// MARK: - Parameters
struct Parameter {
    var isExpanded: Bool
    let title: String
    var list: [ListElement]
}

struct ListElement {
    var name: String
    var isSelected: Bool
}
