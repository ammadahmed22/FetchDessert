//
//  MealDetails.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//
import Foundation

struct MealDetailsResponse: Decodable {
    let meals: [MealDetails]
}

struct MealDetails: Decodable {
    let idMeal: String
    let name: String
    let instructions: String
    let ingredients: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case idMeal = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        // Loop through the possible 20 ingredient and measurement pairs in the API response
        var ingredientsDict = [String: String]()
        for i in 1...20 {
            // Use the ingredient and measurement coding keys to decode their respective values from the response
            if let ingredientKey = CodingKeys(rawValue: "strIngredient\(i)"),
               let measureKey = CodingKeys(rawValue: "strMeasure\(i)"),
               let ingredient = try? container.decode(String.self, forKey: ingredientKey),
               let measure = try? container.decode(String.self, forKey: measureKey),
               !ingredient.isEmpty, !measure.isEmpty {
                ingredientsDict[ingredient] = measure
            }
        }
        self.ingredients = ingredientsDict
    }
}

