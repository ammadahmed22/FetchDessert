//
//  API.swift
//  FetchDessert
//
//  Created by A.d. Ahmed on 9/30/24.
//

import Foundation

struct API {
    static let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    static func mealsURL(category: String) -> URL? {
        var components = URLComponents(string: baseURL + "/filter.php")
        components?.queryItems = [
            URLQueryItem(name: "c", value: category)
        ]
        return components?.url
    }
    
    static func mealDetailsURL(idMeal: String) -> URL? {
        var components = URLComponents(string: baseURL + "/lookup.php")
        components?.queryItems = [
            URLQueryItem(name: "i", value: idMeal)
        ]
        return components?.url
    }
}
