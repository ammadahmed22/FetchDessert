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
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        var ingredientsDict = [String: String]()
        
        // Get the nested container of dynamic keys.
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        // Iterate through ingredient and measure pairs, assuming there are up to 20.
        for i in 1...20 {
            let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(i)")
            let measureKey = DynamicCodingKey(stringValue: "strMeasure\(i)")
            
            if let ingredientKey = ingredientKey, let measureKey = measureKey,
               let ingredient = try? dynamicContainer.decode(String.self, forKey: ingredientKey),
               let measure = try? dynamicContainer.decode(String.self, forKey: measureKey),
               !ingredient.isEmpty {
                ingredientsDict[ingredient] = measure
            }
        }
        self.ingredients = ingredientsDict
    }
}

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}
