//
//  Meal.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let id: UUID = UUID()
    let idMeal: String
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case idMeal = "idMeal"
        case name = "strMeal"
        case imageURL = "strMealThumb"
    }
}

struct MealsResponse: Decodable {
    let meals: [Meal]
}
