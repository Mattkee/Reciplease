//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 08/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class RecipeError: Error {}
    static let error = RecipeError()
    
    static var changeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static let changeIncorrectData = "erreur".data(using: .utf8)!
}
